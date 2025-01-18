//
//  AccountManagementStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 1/7/25.
//

import CoreDomain
import CoreNetwork

import ComposableArchitecture


@Reducer
public struct AccountManagementStore {
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    // TODO: - 연동된 SNS 추가
    var linkedSocialPlatform: String = "Apple"
  }
  
  public enum Action {
    case didTapBackButton
    case didTapLogoutButton
    case didTapWithdrawButton
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
}
