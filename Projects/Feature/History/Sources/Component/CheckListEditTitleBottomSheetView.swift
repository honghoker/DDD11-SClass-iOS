//
//  CheckListEditTitleBottomSheetView.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/12/24.
//

import SwiftUI
import ComposableArchitecture

import SharedDesignSystem

struct CheckListEditTitleBottomSheetView: View {
  @Bindable var store: StoreOf<HistoryStore>
  @FocusState var focus: Bool
  var body: some View {
    VStack(spacing: 13) {
      TopNavigation(
        centerTitle: "",
        trailingItem: (Image.closeCross, {
          store.send(.didTapDismiss)
        })
      )
      HStack {
        Text("제목 변경")
          .notoSans(.headline)
          .foregroundStyle(Color.greyScale950)
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      
      
      InputField(
        errorMessage: .constant(nil),
        text: $store.newTitle,
        placeHolder: store.selected?.title ?? "이름 변경",
        isFocused: $focus
      )
      
      
      VStack {
        CommonButton(
          title: "수정완료",
          style: .default,
          isActive: store.isActive,
          action: {store.send(.didTapEditTitleConfirm)}
        )
        CommonButton(
          title: "취소",
          style: .line,
          isActive: true,
          action: {store.send(.didTapEditTitleCancel)}
        )
      }
      Spacer()
    }
    .padding(.horizontal, 16)
    .onAppear {
      focus = true
    }
  }
  
}
