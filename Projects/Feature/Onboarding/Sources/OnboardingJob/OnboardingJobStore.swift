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
    var selectedCategory: String? = nil
    var detailJobList: [JobType] = []
    
    var isValid: Bool {
      selectedCategory != nil && confirmDetailJob != nil
    }
    
    var showModal: Bool = false
    var selectedJob: JobType?
    var confirmDetailJob: JobType?
    
    var isBottomSheetActive: Bool {
      selectedJob != nil && selectedJob != confirmDetailJob
    }
    
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapJobButton(String, [JobType])
    case didTapBackButton
    case didTapNextButton
    case navigateToNextPage(selectedJob: JobType)
    case navigateToPreviousPage
    
    
    case didTapDismissButton
    case didTapDetailJob(JobType)
    case didTpConfirmDetailJobButton
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .didTapJobButton(let jobType, let detailJobList):
        state.selectedCategory = jobType
        state.detailJobList = detailJobList
        state.showModal = true
        return .none
      case .didTapNextButton:
        guard let selectedJob = state.confirmDetailJob else {
          return .none
        }
        return .send(.navigateToNextPage(selectedJob: selectedJob))
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      case .didTapDismissButton:
        if state.selectedJob == nil {
          state.selectedCategory = nil
        } else {
          if state.confirmDetailJob == nil {
            state.selectedCategory = nil
          }
          state.selectedJob = state.confirmDetailJob
        }
        state.showModal = false
        return .none
      case .didTpConfirmDetailJobButton:
        state.confirmDetailJob = state.selectedJob
        state.showModal = false
        return .none
      case .didTapDetailJob(let job):
        state.selectedJob = job
        return .none
      default:
        return .none
      }
    }
  }
}

