//
//  Request.swift
//  CoreNetwork
//
//  Created by 홍은표 on 8/31/24.
//

import Foundation
import Combine

protocol Request {
  associatedtype Response
  
  var publisher: AnyPublisher<Response, NetworkError> { get }
}

extension Request {
  func response() async -> Result<Response, NetworkError> {
    await publisher.receive(on: DispatchQueue.main).async()
  }
}

private extension Publisher {
  func async() async -> Result<Output, Failure> where Failure == NetworkError {
    await withCheckedContinuation { continuation in
      var cancellable: AnyCancellable?
      var finishedWithoutValue = true
      cancellable = first()
        .sink { result in
          switch result {
          case .finished:
            if finishedWithoutValue {
              continuation.resume(returning: .failure(.unknown))
            }
          case let .failure(error):
            continuation.resume(returning: .failure(error))
          }
          cancellable?.cancel()
        } receiveValue: { value in
          finishedWithoutValue = false
          continuation.resume(returning: .success(value))
        }
    }
  }
}
