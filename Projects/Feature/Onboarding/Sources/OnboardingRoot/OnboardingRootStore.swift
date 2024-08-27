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
    var nickname: String?
    var selectedJob: JobType?
    var workExperience: Int?
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(_ action: BindingAction<State>)
    case path(StackActionOf<Path>)
    case didTapNextButton
  }
  
  @Reducer
  public enum Path {
    case nickName(OnboardingNicknameStore)
    case job(OnboardingJobStore)
    case workExperience(OnboardingWorkExperienceStore)
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .didTapNextButton:
        state.path.append(.nickName(OnboardingNicknameStore.State()))
        return .none
      case let .path(action):
        switch action {
        case .element(id: _, action: .nickName(.navigateNextPage(let nickname))):
          state.nickname = nickname
          state.path.append(.job(OnboardingJobStore.State()))
          return .none
        case .element(id: _, action: .job(.navigateNextPage(let selectedJob))):
          state.selectedJob = selectedJob
          state.path.append(.workExperience(OnboardingWorkExperienceStore.State()))
          return .none
        case .element(id: _, action: .workExperience(.navigateNextPage(let workExperience))):
          state.workExperience = workExperience
          // TODO: AI 설정 완료 View navigate
          return .none
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: \.path)
  }
}
