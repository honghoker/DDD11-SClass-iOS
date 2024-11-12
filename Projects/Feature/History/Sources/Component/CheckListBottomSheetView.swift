//
//  CheckListBottomSheetView.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/12/24.
//

import SwiftUI
import ComposableArchitecture

import SharedDesignSystem
import CoreDomain

struct CheckListBottomSheetView: View {
  @Bindable var store: StoreOf<HistoryStore>
  
  init(store: StoreOf<HistoryStore>) {
    self.store = store
  }
  
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
          .notoSans(.body_3)
          .foregroundStyle(Color.greyScale950)
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .onTapGesture {
        store.send(.didTapEditTitle)
      }
      
      HStack {
        Text("삭제하기")
          .notoSans(.body_3)
          .foregroundStyle(Color(hex: "DD1D1D"))
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .onTapGesture {
        store.send(.didTapDelete)
      }
      Spacer()
    }
  }
}
