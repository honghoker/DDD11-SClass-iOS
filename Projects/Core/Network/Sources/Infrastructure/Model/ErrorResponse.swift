//
//  ErrorResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

struct ErrorResponse: Error, Decodable {
  let error: Error
  
  struct Error: Decodable {
    let message: String
    let error: String
    let code: Int
  }
}

extension ErrorResponse {
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    error = try container.decode(Error.self, forKey: .error)
  }
  
  enum CodingKeys: String, CodingKey {
    case error = "message"
  }
}

extension ErrorResponse.Error {
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.message = try container.decode(String.self, forKey: .message)
    self.error = try container.decode(String.self, forKey: .error)
    self.code = try container.decode(Int.self, forKey: .code)
  }
  
  enum CodingKeys: String, CodingKey {
    case message
    case error
    case code = "statusCode"
  }
}
