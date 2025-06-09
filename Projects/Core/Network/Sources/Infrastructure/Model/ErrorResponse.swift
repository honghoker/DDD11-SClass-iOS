//
//  ErrorResponse.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

struct ErrorResponse: Error, Decodable {
  let timestamp: String
  let status: Int
  let error: String
  let path: String
}
