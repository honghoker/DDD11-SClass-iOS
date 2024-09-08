//
//  CommonResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

struct CommonResponse<T: Decodable>: Decodable {
  let data: T?
}

extension CommonResponse {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    data = try container.decode(T.self, forKey: .data)
  }
  
  private enum CodingKeys: String, CodingKey {
    case data
  }
}
