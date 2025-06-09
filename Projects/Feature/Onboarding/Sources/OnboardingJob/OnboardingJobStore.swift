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
    
    var isValid: Bool {
      selectedRole != nil && detailRole != nil
    }
    
    var showModal: Bool = false
    var selectedRole: JobCategory?
    var detailRoleList: [JobType] = []
    var detailRole: JobType?
  
    
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapJobButton(JobCategory, [JobType])
    case didTapBackButton
    case didTapNextButton
    case navigateToNextPage(role: JobCategory, detailRole: JobType)
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
        state.selectedRole = jobType
        state.detailRoleList = detailJobList
        state.showModal = true
        return .none
      case .didTapNextButton:
        guard let role = state.selectedRole,
          let detailRole = state.detailRole else {
          return .none
        }
        return .send(.navigateToNextPage(role: role, detailRole: detailRole))
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      case .didTapDismissButton:
        if state.selectedRole == nil {
          state.selectedRole = nil
        } else {
          if state.detailRole == nil {
            state.selectedRole = nil
          }
        }
        state.showModal = false
        return .none
      case .didTpConfirmDetailJobButton:
//        state.detailRole = state.selectedJob
        state.showModal = false
        return .none
      case .didTapDetailJob(let job):
        state.detailRole = job
        return .none
      default:
        return .none
      }
    }
  }
}

