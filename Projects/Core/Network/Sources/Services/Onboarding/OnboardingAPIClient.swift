//
//  OnboardingAPIClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 8/31/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import Moya

@DependencyClient
public struct OnboardingAPIClient: Sendable {
  public var postSignUp: @Sendable(_ userInfo: UserInfo) async throws -> Void
}

public extension DependencyValues {
  var onboardingAPIClient: OnboardingAPIClient {
    get { self[OnboardingAPIClient.self] }
    set { self[OnboardingAPIClient.self] = newValue }
  }
}

extension OnboardingAPIClient: DependencyKey {
  public static var liveValue: OnboardingAPIClient = .init(
    postSignUp: { userInfo in
      let signUpRequestDTO: SignUpRequestDTO = .init(
        accessToken: userInfo.accessToken,
        nickname: userInfo.nickName,
        role: userInfo.role.rawValue,
        detailRole: userInfo.detailRole.rawValue,
        workExperience: userInfo.workExperience
      )
      
      let api = OnboardingAPI.signUp(signUpRequestDTO)      
      let responseDTO: String = try await APIService<OnboardingAPI>().request(api: api)
    }
  )
  
  public static var testValue: OnboardingAPIClient = Self()
}
