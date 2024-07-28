//
//  APIService.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

import Combine
import Moya

class APIService<API: BaseAPI>: Requestable {
  
  let provider = NetworkProvider<API>()
  var cancelable = Set<AnyCancellable>()
  
  func mapAPIResponse<T: Decodable>(api: API) -> AnyPublisher<T, ErrorResponse> {
    return provider.request(api)
      .tryMap { response in
        let commonResponse = try JSONDecoder().decode(CommonResponse<T>.self, from: response.data)
        print("response: \(commonResponse)")
        
        if let data = commonResponse.data {
          return data
        } else {
          throw commonResponse.error
        }
      }
      .mapError { error in
        if let customError = error as? ErrorResponse {
          return customError
        } else {
          return ErrorResponse.defaultError
        }
      }
      .eraseToAnyPublisher()
  }
}
