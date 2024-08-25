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
  
  @ObservableState
  public struct State {
    var nickname: String = ""
    var errorText: String?
    var isValid: Bool = false
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapNextButton
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .didTapNextButton:
        isValidName(<#T##text: String##String#>)
        // 다음 화면 navigation
        return .none
      }
    }
  }
  
  // TODO: - usecase로 분리
  
  private func isValidName(_ text: String) -> Bool {
    guard !text.isEmpty else { return false }
    let isValid = regEx(text: text)
    if isValid {
//      errorText = nil
    } else {
//      errorText = "닉네임은 8자 이하로 알파벳과 한글만 조합할 수 있어요."
    }
    return isValid
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
