//
//  OnboardingNicknameView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct OnboardingNicknameView: View {
  @Bindable private var store: StoreOf<OnboardingNicknameStore>
  @FocusState private var focusState
  
  public init(store: StoreOf<OnboardingNicknameStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      TopNavigation(
        leadingItem: (
          .left,
          {
            store.send(.didTapBackButton)
          }
        ),
        centerTitle: "나만의 AI 만들기"
      )
      
      CommonProgressBar(progress: 0.333)
      
      VStack(spacing: 8) {
        Text("닉네임을 설정해주세요")
          .notoSans(.display_1)
          .foregroundStyle(.black)
        
        Text("닉네임은 8자 이하, 공백 및 특수기호는 불가능해요")
          .notoSans(.body_1)
          .foregroundStyle(.greyScale500)
      }
      .padding(.top, 81)
      
      InputField(
        errorMessage: $store.errorText,
        text: $store.nickname,
        placeHolder: "닉네임을 입력해주세요",
        isFocused: $focusState
      )
      .frame(width: 289)
      .padding(.top, 86)
      .onChange(of: store.nickname) { _, newValue in
        store.send(.onChangeNickname)
      }
      
      Spacer()
      
      CommonButton(
        title: "다음",
        style: .default,
        isActive: store.isValid,
        action: {
          store.send(.didTapNextButton)
        }
      )
      .padding(.horizontal, 15)
      .padding(.bottom, 50)
    }
    .navigationBarBackButtonHidden()
  }
}
