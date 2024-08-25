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
//    public var onBoardingNickname = OnboardingNicknameStore.State()
    
    public init() { }
  }
  
  public enum Action {
    case path(StackActionOf<Path>)
//    case binding(_ action: BindingAction<State>)
//    case onBoardingHello(OnboardingHelloStore.Action)
    case didTapNextButton
  }
  
  @Reducer
  public enum Path {
    case nickName(OnboardingNicknameStore)
//    case job
//    case workExperience
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapNextButton:
        state.path.append(.nickName(OnboardingNicknameStore.State()))
        return .none
      case let .path(action):
        switch action {
        case .element(id: _, action: .nickName):
          state.path.append(.nickName(OnboardingNicknameStore.State()))
          return .none
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: \.path)
  }
}
