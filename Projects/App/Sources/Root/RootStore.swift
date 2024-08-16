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
    case mainTab(MainTabStore.State)
    
    public init() {
      self = .mainTab(MainTabStore.State(.home))
    }
  }
  
  public enum Action {
    case mainTab(MainTabStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .mainTab:
        return .none
      }
    }
    .ifCaseLet(\.mainTab, action: \.mainTab) {
      MainTabStore()
    }
  }
}
