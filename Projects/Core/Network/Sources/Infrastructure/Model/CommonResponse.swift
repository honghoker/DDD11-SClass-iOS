//
//  CommonResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

// TODO: api json 형식 나오면 추후 수정 예정
struct CommonResponse<T: Decodable>: Decodable {
  let success: Bool
  let data: T?
  let error: ErrorResponse?
  
  enum CodingKeys: CodingKey {
    case success
    case data
    case error
  }
}
