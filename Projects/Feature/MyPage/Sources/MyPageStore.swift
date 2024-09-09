//
//  MyPageStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 8/9/24.
//

import Foundation

import CoreCommon
import CoreDomain

import ComposableArchitecture

@Reducer
public struct MyPageStore {
  public init() { }
  
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    var nickname: String = ""
    
    public init() {
      
    }
  }
  
  public enum Action: BindableAction {
    case binding(_ action: BindingAction<State>)
    case onAppear
    case didTapPrivacyPolicy
    case didTapTermsOfService
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .onAppear:
        state.nickname = state.userInfo?.nickName ?? ""
        return .none
      case .didTapPrivacyPolicy:
        return .none
      case .didTapTermsOfService:
        return .none
      }
    }
  }
}
