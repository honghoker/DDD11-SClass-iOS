//
//  EnterKeywordView.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem

struct EnterKeywordView: View {
  @Bindable var store: StoreOf<EnterKeywordStore>
  @Bindable var navigationStore: StoreOf<ChatNavigationStore>
  
  @FocusState var isFocused: Bool
  
  var body: some View {
    VStack(spacing: 0) {
      TopNavigation(
        leadingItem: (Image.left, {
          navigationStore.send(.pop)
        }),
        centerTitle: "프로젝트 저장"
      )
      .padding(.bottom, 64)
      
      VStack(spacing: 32) {
        VStack(spacing: 4) {
          Text("체크리스트를 저장할\n대표적인 키워드를 설정해주세요.")
            .notoSans(.display_1)
            .multilineTextAlignment(.center)
          Text("가장 알아보기 쉬운 단어로 적어보세요")
            .notoSans(.body_1)
        }
        InputField(
          errorMessage: $store.errorMessage,
          text: $store.text,
          placeHolder: "3~8글자의 단어로 입력해볼까요?",
          isFocused: $isFocused
        )
        .focused($isFocused)
        .padding(.horizontal, 64)
      }
      Spacer()
      
      CommonButton(
        title: "저장하기",
        style: .default,
        isActive: true,
        action: {
          store.send(.didTapSaveButton)
        }
      ).padding(16)
    }
    .navigationBarBackButtonHidden()
  }
}


