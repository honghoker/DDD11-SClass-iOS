//
//  OnboardingRootStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingRootStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var path: StackState<Path.State> = .init()
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(_ action: BindingAction<State>)
    case path(StackActionOf<Path>)
  }
  
  @Reducer
  public enum Path {
  }
 
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}
