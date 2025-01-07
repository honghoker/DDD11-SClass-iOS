//
//  RootStore.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/27/24.
//

import Foundation

import Feature

import ComposableArchitecture

@Reducer
public struct RootStore {
  @ObservableState
  public enum State {
    case splash(SplashStore.State)
    case onboarding(OnboardingRootStore.State)
    case mainTab(MainTabStore.State)
    
    init() {
      self = .mainTab(.init(.history))//.splash(SplashStore.State())
    }
  }
  
  public enum Action {
    case splash(SplashStore.Action)
    case onboarding(OnboardingRootStore.Action)
    case mainTab(MainTabStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .splash(.routeToMainTabScreen):
        state = .mainTab(MainTabStore.State(.home))
        return .none
      case .splash(.routeToOnboardingScreen):
        state = .onboarding(OnboardingRootStore.State())
        return .none
      case .onboarding(.onSuccessSignUp):
        state = .mainTab(MainTabStore.State(.home))
        return .none
      case .mainTab:
        return .none
      default:
        return .none
      }
    }
    .ifCaseLet(\.splash, action: \.splash) {
      SplashStore()
    }
    .ifCaseLet(\.onboarding, action: \.onboarding) {
      OnboardingRootStore()
    }
    .ifCaseLet(\.mainTab, action: \.mainTab) {
      MainTabStore()
    }
  }
}
