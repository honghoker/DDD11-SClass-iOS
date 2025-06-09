//
//  AutrhService.swift
//  CoreNetwork
//
//  Created by 현수빈 on 5/27/25.
//

import Foundation

@globalActor
actor AuthService {
  static let shared = AuthService()
  
  let keychainClient = KeychainClient.liveValue
  
  func refreshToken() async throws {
    guard let refreshToken = keychainClient.refreshToken
    else { throw NetworkError.tokenRefreshFailed }
    
    
    let api = LoginAPI.refreshToken(refreshToken)
    let response = try await NetworkProvider<LoginAPI>().request(api)
    
    let decoded = try JSONDecoder().decode(CommonResponse<TokenInfo>.self, from: response.data)
    guard let newToken = decoded.data
    else {
      throw NetworkError.tokenRefreshFailed
    }
    
    keychainClient.setAccessToken(newToken.accessToken)
    keychainClient.setAccessToken(newToken.refreshToken)
  }
}
