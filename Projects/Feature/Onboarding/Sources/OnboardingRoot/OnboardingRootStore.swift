//
//  OnboardingRootStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import Foundation

import Core

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
    case onCompleteSetting(TaskResult<Void>)
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
  @Dependency(KeychainClient.self) var keychainClient
  
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
        // TODO: 회원가입 API 예외 처리
        debugPrint("onCompleteSetting error: \(error)")
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
          let job = state.selectedJob,
          let workExperience = state.workExperience
    else {
      return .none
    }
    
    let userID: String = UUID().uuidString
    let userInfo: UserInfo = .init(
      userID: userID,
      nickName: nickname,
      job: job,
      workExperience: workExperience
    )
    
    return .run { send in
      do {
        try await onboardingAPIClient.postSignUp(userInfo)
        keychainClient.setUserID(userID)
        await send(.onCompleteSetting(.success(())))
      } catch {
        await send(.onCompleteSetting(.failure(error)))
      }
    }
  }
}
