//
//  OnboardingNicknameStore.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/26/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct OnboardingNicknameStore {
  
  public init() { }
  
  @ObservableState
  public struct State {
    var nickname: String = ""
    var errorText: String?
    var isValid: Bool = false
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onChangeNickname
    case didTapBackButton
    case didTapNextButton
    case navigateToNextPage(nickname: String)
    case navigateToPreviousPage
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onChangeNickname:
        state.isValid = !state.nickname.isEmpty
        state.errorText = nil
        return .none
      case .didTapNextButton:
        let isValid = isValid(nickName: state.nickname)
        state.isValid = isValid
        
        if !isValid {
          state.errorText = "닉네임은 8자 이하로 알파벳과 한글만 조합할 수 있어요."
          return .none
        }
        state.errorText = nil
        return .send(.navigateToNextPage(nickname: state.nickname))
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      default:
        return .none
      }
    }
  }
  
  // TODO: - 아래 usecase로 분리
  
  private func isValid(nickName text: String) -> Bool {
    guard !text.isEmpty else { return false }
    return regEx(text: text)
  }
  
  private func regEx(text str: String) -> Bool {
    let pattern = "^[A-Za-z가-힣]{1,8}$"
    
    guard let regex = try? NSRegularExpression(
      pattern: pattern,
      options: .caseInsensitive
    ) else {
      return false
    }
    
    let matches = regex.matches(
      in: str,
      options: [],
      range: NSRange(location: 0, length: str.utf16.count)
    )
    
    return matches.count > 0
  }
}
