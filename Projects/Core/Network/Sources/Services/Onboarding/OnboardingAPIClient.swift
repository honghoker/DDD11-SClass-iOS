//
//  OnboardingAPIClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 8/31/24.
//

import Foundation
import ComposableArchitecture
import Combine
import CombineMoya
import Moya

@DependencyClient
public struct OnboardingAPIClient: Sendable {
  public var postSignUp: @Sendable(
    _ userID: String,
    _ nickname: String,
    _ job: String,
    _ workExperience: Int
  ) async throws -> Void
}

public extension DependencyValues {
  var onboardingAPIClient: OnboardingAPIClient {
    get { self[OnboardingAPIClient.self] }
    set { self[OnboardingAPIClient.self] = newValue }
  }
}

extension OnboardingAPIClient: DependencyKey {
  public static var liveValue: OnboardingAPIClient = .init(
    postSignUp: { userID, nickname, job, workExperience in
      let api = OnboardingAPI.signUp(
        userID: userID,
        nickname: nickname,
        job: job,
        workExperience: workExperience
      )
      
      _ = try await NetworkProvider<OnboardingAPI>().request(api)
    }
  )
  
  public static var testValue: OnboardingAPIClient = Self()
}
