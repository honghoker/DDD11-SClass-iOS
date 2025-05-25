//
//  LoginStore.swift
//  FeatureLogin
//
//  Created by 현수빈 on 1/8/25.
//

import AuthenticationServices
import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture
import KakaoSDKUser

@Reducer
public struct LoginStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var isLoading = false
    var user: UserInfo? = nil
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    case didTapKakaoLogin
    case didTapAppleLogin
    
    case loginServer(SocialLoginInfo)
    case loginSuccess(TokenInfo, SocialLoginType)
    case loginFailure(Error)
    
    case didTapGuestLogin
    case setLoading(Bool)
    
    case routeToOnboardingScreen
  }

  @Dependency(\.socialLogin) private var socialLogin
  @Dependency(\.loginAPIClient) private var loginAPIClient
  @Dependency(KeychainClient.self) var keychainClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state,action in
      switch action {
      case .binding:
        return .none
      case .didTapGuestLogin:
        return .send(.routeToOnboardingScreen)
        
      case .routeToOnboardingScreen:
        return .none
        
      case .didTapKakaoLogin:
          return .run(
            operation: { send in
              if (UserApi.isKakaoTalkLoginAvailable()) {
                await send(.setLoading(true))
                let info = try await socialLogin.kakaoLogin()
                await send(.loginServer(info))
              } else {
                throw NSError()
              }
            },
            catch: { error, send in
              debugPrint(error)        
              await send(.setLoading(false))
              await send(.loginFailure(error))
            }
          )
        
      case let .loginServer(userInfo):
        return .run { [info = userInfo] send in
          do {
            let loginToken = try await loginAPIClient.login(info)
            await send(.loginSuccess(
              loginToken,
              info.provider
            ))
          } catch {
            debugPrint(error)
            await send(.setLoading(false))
            await send(.loginFailure(error))
          }
        }
        
      case let .loginSuccess(id, socialLoginType):
        return .run { [id = id, socialLoginType = socialLoginType.rawValue] send in
          keychainClient.setAccessToken(id.accessToken)
          keychainClient.setRefreshToken(id.refreshToken)
          keychainClient.setSocialLoginType(socialLoginType)
          await send(.setLoading(false))
        }
        
      case let .loginFailure(error):
        // TODO: 로그인 에러 처리
        debugPrint("로그인 API 에러 발생: \(error)")
        return .send(.setLoading(false))
        
      case .didTapAppleLogin:
        return .run(
          operation: { send in
            await send(.setLoading(true))
            let info = try await socialLogin.appleLogin()
            await send(.loginServer(info))
          },
          catch: { error, send in
            await send(.setLoading(false))
            
            guard let appleAuthError = error as? AppleErrorType else {
              await send(.loginFailure(error))
              return
            }
            
            if case .dismissASAuthorizationController = appleAuthError {
              return
            }
            
            await send(.loginFailure(error))
          }
        )
      case let .setLoading(new):
        state.isLoading = new
        return .none
      }
    }
  }
}

