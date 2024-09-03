//
//  OnboardingWorkExperienceStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/28/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingWorkExperienceStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var workExperienceList: [Int] = (0..<10).map { $0 }
    var workExperience: Int = 0
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapBackButton
    case didTapNextButton
    case navigateToNextPage(workExperience: Int)
    case navigateToPreviousPage
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .didTapNextButton:
        return .send(.navigateToNextPage(workExperience: state.workExperience))
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      default:
        return .none
      }
    }
  }
}

