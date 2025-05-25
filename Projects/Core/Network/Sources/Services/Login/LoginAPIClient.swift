//
//  LoginAPIClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 5/14/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public struct LoginAPIClient: Sendable {
  public var login: @Sendable(_ userInfo: SocialLoginInfo) async throws -> TokenInfo
}

public extension DependencyValues {
  var loginAPIClient: LoginAPIClient {
    get { self[LoginAPIClient.self] }
    set { self[LoginAPIClient.self] = newValue }
  }
}

extension LoginAPIClient: DependencyKey {
  public static var liveValue: LoginAPIClient = .init(
    login: { userInfo in
      let api = LoginAPI.login(userInfo)
      let responseDTO: TokenInfo = try await APIService<LoginAPI>().request(api: api)
      return responseDTO
    }
  )
}

