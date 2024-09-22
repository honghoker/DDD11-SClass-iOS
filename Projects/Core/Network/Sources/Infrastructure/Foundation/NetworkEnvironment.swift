//
//  NetworkEnvironment.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

enum NetworkEnvironment {
  static var baseURL: String {
    guard let url = Bundle.main.infoDictionary?["baseURL"] as? String
    else {
      fatalError("Base URL is not set in plist for this configuration.")
    }
    return url
  }
}

extension NetworkEnvironment {
  enum HTTPHeaderField {
    static let `default`: [String: String] = [
      "Content-Type": "application/json"
    ]
  }
}
