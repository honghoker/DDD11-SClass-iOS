//
//  SplashStore.swift
//  FeatureSplash
//
//  Created by 홍은표 on 9/6/24.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork
import Shared

import ComposableArchitecture

@Reducer
public struct SplashStore {
  public init() { }
  
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    
    public init() { }
  }
  
  public enum Action {
    case onAppear
    case routeToLoginScreen
    case routeToOnboardingScreen
    case routeToMainTabScreen
    case fetchUser(TaskResult<UserInfo>)
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  @Dependency(MyPageAPIClient.self) var myPageAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return handleRouting(state.userInfo)
      case .routeToLoginScreen:
        return .none
      case .routeToOnboardingScreen:
        return .none
      case .routeToMainTabScreen:
        return .none
      case .fetchUser(.success(let userInfo)):
        state.userInfo = userInfo
        return .send(.routeToMainTabScreen)
      case .fetchUser(.failure(let error)):
        if error is CommonError {
          return .send(.routeToOnboardingScreen)
        } else {
          return .send(.routeToLoginScreen)
        }
      }
    }
  }
  
  private func handleRouting(_ info: UserInfo?) -> Effect<Action> {
    if keychainClient.isSignIn { // accessToken이 키체인이 있는 경우 api 호출
      return requestFetchUser()
    } else { // accessToken이 키체인이 없는 경우 로그인으로 이동
      return .send(.routeToLoginScreen)
    } 
  }
  
  private func requestFetchUser() -> Effect<Action> {
    return .run { send in
      await send(.fetchUser(
        TaskResult {
          let result = try await myPageAPIClient.fetchUser()
          
          if result.nickName.isEmpty { // 유저 정보가 없는 경우 온보딩으로 이동
            throw CommonError.needOnboarding
          } else {
            return result
          }
        }
      ))
    }
  }
}
