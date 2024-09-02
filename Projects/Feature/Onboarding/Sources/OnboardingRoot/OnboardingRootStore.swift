//
//  OnboardingRootStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import Foundation

import Core
import Domain

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
    case didTapCompleteButton
    case onCompleteSetting(Result<Void, Error>)
    case onSuccessSignUp
  }
  
  @Reducer
  public enum Path {
    case nickName(OnboardingNicknameStore)
    case job(OnboardingJobStore)
    case workExperience(OnboardingWorkExperienceStore)
    case complete
  }
  
  @Dependency(OnboardingAPIClient.self) var onboardingAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .didTapNextButton:
        state.path.append(.nickName(OnboardingNicknameStore.State()))
        return .none
      case .didTapCompleteButton:
        return .send(.onSuccessSignUp)
      case .onCompleteSetting(.success):
        state.path.append(.complete)
        return .none
      case .onCompleteSetting(.failure(let error)):
        print("onCompleteSetting error: \(error)")
        return .none
      case let .path(action):
        return handlePathAction(state: &state, action: action)
      case .onSuccessSignUp:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
  
  private func handlePathAction(state: inout State, action: StackActionOf<Path>) -> Effect<Action> {
    switch action {
    case .element(id: _, action: .nickName(.navigateToNextPage(let nickname))):
      state.nickname = nickname
      state.path.append(.job(OnboardingJobStore.State()))
      return .none
      
    case .element(id: _, action: .nickName(.navigateToPreviousPage)):
      state.path.removeLast()
      return .none
      
    case .element(id: _, action: .job(.navigateToNextPage(let selectedJob))):
      state.selectedJob = selectedJob
      state.path.append(.workExperience(OnboardingWorkExperienceStore.State()))
      return .none
      
    case .element(id: _, action: .job(.navigateToPreviousPage)):
      state.path.removeLast()
      return .none
      
    case .element(id: _, action: .workExperience(.navigateToNextPage(let workExperience))):
      state.workExperience = workExperience
      return requestSignUp(state: &state)

    case .element(id: _, action: .workExperience(.navigateToPreviousPage)):
      state.path.removeLast()
      return .none
      
    default:
      return .none
    }
  }
  
  private func requestSignUp(state: inout State) -> Effect<Action> {
    // TODO: 요청 시 로딩 화면 이동
    
    guard let nickname = state.nickname,
          let job = state.selectedJob?.rawValue,
          let workExperience = state.workExperience
    else {
      return .none
    }
    
    
    // TODO: UserID Generator(Keychain)
    let userID: String = "mockId2"
    
    return .run { send in
      await send(
        .onCompleteSetting(
          .init {
            try await onboardingAPIClient.postSignUp(userID, nickname, job, workExperience)
          }
        )
      )
    }
  }
}
