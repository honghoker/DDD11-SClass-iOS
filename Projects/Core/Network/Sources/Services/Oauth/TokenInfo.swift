//
//  TokenInfo.swift
//  CoreNetwork
//
//  Created by 현수빈 on 1/15/25.
//

import Foundation

public struct TokenInfo: Decodable {
  public let accessToken: String
  public let refreshToken: String
  public let tokenType: String
  
  public init(accessToken: String, refreshToken: String, tokenType: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
    self.tokenType = tokenType
  }
}
