//
//  NetworkProvider.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

import Combine
import CombineMoya
import Moya

protocol Requestable {
  associatedtype API: BaseAPI
  
  func request(_ endpoint: API) -> AnyPublisher<Response, MoyaError>
}

extension Requestable {
  func request(_ endpoint: API) -> AnyPublisher<Response, MoyaError> {
    self.request(endpoint)
  }
}

final class NetworkProvider<API: BaseAPI>: Requestable {
  
  private let provider: MoyaProvider<API>
  
  init(plugins: [PluginType] = []) {
    let session = MoyaProvider<API>.defaultAlamofireSession()
    session.sessionConfiguration.timeoutIntervalForRequest = 30
    
    self.provider = MoyaProvider(session: session, plugins: plugins)
  }
  
  func request(_ api: API) async throws -> Response {
    return try await provider.asyncRequest(api)
  }
}

fileprivate extension MoyaProvider {
  func asyncRequest(_ api: Target) async throws -> Response {
    try await withCheckedThrowingContinuation { continuation in
      self.request(api) { result in
        switch result {
        case .success(let response):
          continuation.resume(returning: response)
        case .failure(let error):
          continuation.resume(throwing: NetworkError.underlying(error))
        }
      }
    }
  }
}
