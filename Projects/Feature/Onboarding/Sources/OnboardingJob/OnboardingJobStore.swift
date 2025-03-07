//
//  OnboardingJobStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/28/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture

@Reducer
public struct OnboardingJobStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var selectRootJob: String? = nil
    var selectedJob: JobType?
    var isValid: Bool = false
    public init() { }
  }
  
  public enum Action {
    case didTapJobButton(String, [JobType])
    case didTapBackButton
    case didTapNextButton
    case navigateToNextPage(selectedJob: JobType)
    case navigateToPreviousPage
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapJobButton(let jobType, let subJobList):
        if !state.isValid { state.isValid = true }
        state.selectRootJob = jobType
        // TODO: 수정 필요
        return .none
      case .didTapNextButton:
        guard let selectedJob = state.selectedJob else {
          return .none
        }
        return .send(.navigateToNextPage(selectedJob: selectedJob))
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      default:
        return .none
      }
    }
  }
}

