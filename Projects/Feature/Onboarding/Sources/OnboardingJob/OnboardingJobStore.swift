//
//  OnboardingJobStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/28/24.
//

import Foundation
import ComposableArchitecture

public enum JobType: CaseIterable, Identifiable {
  case designer
  case developer
  case planner
  
  public var id: Self {
    return self
  }
  
  public var name: String {
    switch self {
    case .designer:
      return "디자이너"
    case .developer:
      return "개발자"
    case .planner:
      return "기획자"
    }
  }
}

@Reducer
public struct OnboardingJobStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var selectedJob: JobType?
    var isValid: Bool = false
    public init() { }
  }
  
  public enum Action {
    case didTapJobButton(JobType)
    case didTapNextButton
    case navigateNextPage(selectedJob: JobType)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapJobButton(let jobType):
        if !state.isValid { state.isValid = true }
        state.selectedJob = jobType
        return .none
      case .didTapNextButton:
        guard let selectedJob = state.selectedJob else {
          return .none
        }
        return .send(.navigateNextPage(selectedJob: selectedJob))
      default:
        return .none
      }
    }
  }
}

