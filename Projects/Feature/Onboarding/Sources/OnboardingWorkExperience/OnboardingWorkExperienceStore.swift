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
    case didTapNextButton
    case navigateNextPage(workExperience: Int)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .didTapNextButton:
        return .send(.navigateNextPage(workExperience: state.workExperience))
      default:
        return .none
      }
    }
  }
}

