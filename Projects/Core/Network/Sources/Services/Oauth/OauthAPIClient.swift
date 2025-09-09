//
//  OauthAPIClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 5/14/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public struct OauthAPIClient: Sendable {
  public var login: @Sendable(_ userInfo: SocialLoginInfo) async throws -> TokenInfo
  public var logout: @Sendable () async throws -> Void
  public var withdraw: @Sendable () async throws -> Void
}

public extension DependencyValues {
  var oauthAPIClient: OauthAPIClient {
    get { self[OauthAPIClient.self] }
    set { self[OauthAPIClient.self] = newValue }
  }
}

extension OauthAPIClient: DependencyKey {
  public static var liveValue: OauthAPIClient = .init(
    login: { userInfo in
      let api = OauthAPI.login(userInfo)
      let responseDTO: TokenInfo = try await APIService<OauthAPI>().request(api: api)
      return responseDTO
    },
    logout: {
      let api = OauthAPI.logout
      let responseDTO: EmptyResponseDTO = try await APIService<OauthAPI>().request(api: api)
    },
    withdraw: {
      let api = OauthAPI.withdraw
      let responseDTO: EmptyResponseDTO = try await APIService<OauthAPI>().request(api: api)
    }
  )
}
