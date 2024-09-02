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
    case onboarding(OnboardingRootStore.State)
    case mainTab(MainTabStore.State)
    
    public init() {
      self = .onboarding(OnboardingRootStore.State())
    }
  }
  
  public enum Action {
    case onboarding(OnboardingRootStore.Action)
    case mainTab(MainTabStore.Action)
    case onSuccessSignUp
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onboarding(.onSuccessSignUp):
        state = .mainTab(MainTabStore.State(.home))
        return .none
      case .mainTab:
        return .none
      default:
        return .none
      }
    }
    .ifCaseLet(\.onboarding, action: \.onboarding) {
      OnboardingRootStore()
    }
    .ifCaseLet(\.mainTab, action: \.mainTab) {
      MainTabStore()
    }
  }
}
