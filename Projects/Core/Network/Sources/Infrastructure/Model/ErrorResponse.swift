//
//  ErrorResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

struct ErrorResponse: Error, Decodable {
  let code: NetworkError
  let message: String
  
  enum CodingKeys: CodingKey {
    case code
    case message
  }
  
  init(code: NetworkError, message: String) {
    self.code = code
    self.message = message
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let codeRawValue = try container.decode(Int.self, forKey: .code)
    self.code = .init(rawValue: codeRawValue) ?? .unknown
    self.message = try container.decode(String.self, forKey: .message)
  }
}

extension ErrorResponse {
  public var errorDescription: String {
    return "\(message)(코드: \(code.rawValue))"
  }
  
  static let defaultError = ErrorResponse(
    code: .unknown,
    message: "알 수 없는 에러"
  )
}
