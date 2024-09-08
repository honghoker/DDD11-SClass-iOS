//
//  SplashStore.swift
//  FeatureSplash
//
//  Created by 홍은표 on 9/6/24.
//

import Foundation

import CoreNetwork

import ComposableArchitecture

@Reducer
public struct SplashStore {
  public init() { }
  
  @ObservableState
  public struct State {
    public init() { }
  }
  
  public enum Action {
    case onAppear
    case routeToOnboardingScreen
    case routeToMainTabScreen
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return handleRouting()
      case .routeToOnboardingScreen:
        return .none
      case .routeToMainTabScreen:
        return .none
      }
    }
  }
  
  private func handleRouting() -> Effect<Action> {
    if keychainClient.isSignIn {
      return .send(.routeToMainTabScreen)
    } else {
      return .send(.routeToOnboardingScreen)
    }
  }
}
