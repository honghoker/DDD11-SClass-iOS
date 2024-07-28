//
//  NetworkEnvironment.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

enum NetworkEnvironment {
  static let baseURL = ""
}

extension NetworkEnvironment {
  enum HTTPHeaderField {
    static let `default`: [String: String] = [
      "Content-Type": "application/json"
    ]
  }
}
