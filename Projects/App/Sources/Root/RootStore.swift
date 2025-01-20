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
      self = .splash(.init())
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
        state = .mainTab(.init(.home))
        return .none
        
      case .splash(.routeToOnboardingScreen):
        state = .onboarding(.init())
        return .none
        
      case .onboarding(.onSuccessSignUp):
        state = .mainTab(.init(.home))
        return .none
      
      case .mainTab(.routeToLoginPage):
        // TODO: - 로그인 페이지로 이동하도록 변경
        state = .onboarding(.init())
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
