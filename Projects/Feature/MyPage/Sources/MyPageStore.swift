//
//  MyPageStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 8/9/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct MyPageStore {
  public init() { }
  
  @ObservableState
  public struct State {
    public init() {
      
    }
  }
  
  public enum Action {
    case didTapPrivacyPolicy
    case didTapTermsOfService
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
}
