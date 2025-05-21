//
//  CommonResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

struct CommonResponse<T: Decodable>: Decodable {
  let code: Int
  let message: String
  let data: T?
}

extension CommonResponse {
  
  enum CodingKeys: String, CodingKey {
    case code
    case message
    case data
  }
}
