//
//  APIService.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

class APIService<API: BaseAPI>: Requestable {
  let provider = NetworkProvider<API>()
  
  func request<T: Decodable>(api: API) async throws -> T {
    let response = try await provider.request(api)
    
    if let httpResponse = response.response, 200 ..< 500 ~= httpResponse.statusCode {
      let decodedResponse = try JSONDecoder().decode(CommonResponse<T>.self, from: response.data)
      print("response: \(decodedResponse)")
      if let responseData = decodedResponse.data {
        return responseData
      } else {
        throw NetworkError.noData
      }
    } else {
      let decodedError = try JSONDecoder().decode(ErrorResponse.self, from: response.data)
      let error = decodedError.error
      throw NetworkError.invalidResponse(statusCode: error.code, message: error.message)
    }
  }
}
