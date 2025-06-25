//
//  APIService.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

class APIService<API: BaseAPI>: Requestable {
  let provider = NetworkProvider<API>()
  
  let authService = AuthService.shared
  
  func request<T: Decodable>(api: API) async throws -> T {
    do {
      return try await performRequest(api: api)
    } catch let error as NetworkError {
      if case .invalidResponse(let statusCode, _) = error, statusCode == 403 {
        do {
          try await authService.refreshToken()
          return try await performRequest(api: api)
        } catch {
          throw NetworkError.tokenRefreshFailed
        }
      } else {
        throw error
      }
    }
  }
  
  private func performRequest<T: Decodable>(api: API) async throws -> T {
    debugPrint("request: \(String(describing: api.parameters)) \(api.path)")
    let response = try await provider.request(api)
    
    if let httpResponse = response.response, 200 ... 400 ~= httpResponse.statusCode {
      let decodedResponse = try JSONDecoder().decode(CommonResponse<T>.self, from: response.data)
      debugPrint("response: \(decodedResponse)")
      guard let responseData = decodedResponse.data
      else { throw NetworkError.noData }
      return responseData
      
    } else if response.statusCode == 403 { // TODO: 에러 response가 협의한 것과 다르게 와서 임시 처리
      throw NetworkError.invalidResponse(statusCode: 403, message: "access token 만료")
    } else {
      let error = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
      throw NetworkError.invalidResponse(statusCode: error.status, message: error.error)
    }
  }
}
