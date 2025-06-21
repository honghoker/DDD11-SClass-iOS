//
//  PrettyNetworkLoggerPlugin.swift
//  CoreNetwork
//
//  Created by eunpyo on 6/21/25.
//

import Foundation

import Moya

public final class PrettyNetworkLoggerPlugin: PluginType {

  /// Duration Time 로깅용
  private var startDates: [Int: Date] = [:]

  // MARK: - Request

  public func willSend(_ request: RequestType, target: TargetType) {
    guard let urlRequest = request.request else {
      return
    }

    let key = urlRequest.hashValue
    startDates[key] = Date()
    let url = urlRequest.url?.absoluteString ?? ""
    let method = urlRequest.httpMethod ?? ""
    let headers = urlRequest.allHTTPHeaderFields ?? [:]
    let body = urlRequest.httpBody.flatMap { $0.toPrettyPrintedString } ?? "요청 바디 없음"

    print(
        """
        ----------------------- 🌐 Network Request -----------------------
        [ID]: \(key)
        [URL]: \(url)
        [Method]: \(method)
        [Headers]: \(headers.toPrettyPrintedString)
        [Body]: \(body)
        """
    )
  }

  // MARK: - Response

  public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    switch result {
    case .success(let response):
      handleSuccess(response: response)

    case .failure(let error):
      handleFailure(error: error)
    }
  }

  // MARK: - Handling

  private func handleSuccess(response: Moya.Response) {
    log(response: response, isSucceed: true)
  }

  private func handleFailure(error: MoyaError) {
    guard let response = error.response else {
      print("❌ [RESPONSE ERROR] \(error) (해당 요청에 대한 HTTP 응답이 없습니다)")
      return
    }

    log(response: response, isSucceed: false)
  }

  private func log(response: Moya.Response, isSucceed: Bool) {
    let emoji: String = isSucceed ? "✅" : "❌"
    let key = response.request?.hashValue ?? 0
    let url = response.request?.url?.absoluteString ?? ""
    let statusCode = response.statusCode
    let headers = response.response?.allHeaderFields ?? [:]
    let startDate = startDates.removeValue(forKey: key) ?? Date()
    let duration = String(format: "%.3f ms", Date().timeIntervalSince(startDate) * 1000)
    let responseData = response.data.toPrettyPrintedString ?? ""

    print(
        """
        ----------------------- \(emoji) Network Response ----------------------- 
        - [ID]: \(key)
        - [URL]: \(url)
        - [Status]: \(statusCode)
        - [Headers]: \(headers.toPrettyPrintedString)
        - [Duration]: \(duration)
        - [Response]: \(responseData)
        """
    )
  }
}

fileprivate extension Dictionary {
  var toPrettyPrintedString: String {
    guard JSONSerialization.isValidJSONObject(self),
          let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
          let str = String(data: data, encoding: .utf8) else {
      return String(describing: self)
    }
    return str
  }
}

fileprivate extension Data {
  var toPrettyPrintedString: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
    else {
      return nil
    }
    return prettyPrintedString as String
  }
}
