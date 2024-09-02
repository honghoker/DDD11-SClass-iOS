//
//  OnboardingRootView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/25
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct OnboardingRootView: View {
  @Bindable private var store: StoreOf<OnboardingRootStore>
  
  public init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      OnboardingHelloView(store: store)
    } destination: { store in
      switch store.case {
      case .nickName(let store):
        OnboardingNicknameView(store: store)
      case .job(let store):
        OnboardingJobView(store: store)
      case .workExperience(let store):
        OnboardingWorkExperienceView(store: store)
      case .complete:
        OnboardingCompleteView(store: self.store)
      }
    }
  }
}
