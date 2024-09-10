//
//  MyPageView.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 9/12/24.
//

import Foundation
import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct MyPageView: View {
  @Bindable private var store: StoreOf<MyPageStore>
  
  init(store: StoreOf<MyPageStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      headerView
      documentList
      Spacer()
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
  
  private var headerView: some View {
    VStack(alignment: .leading, spacing: 40) {
      Text(
      """
      안녕하세요
      \(store.nickname) 님
      """
      )
      .notoSans(.display_1)
      .foregroundStyle(.greyScale950)
      
      Divider()
        .background(Color(hex: "DADADA"))
    }
    .padding(.top, 53)
    .padding(.horizontal, 16)
    .padding(.bottom, 30)
  }
  
  private var documentList: some View {
    ForEach(store.documents) { document in
      MyPageCellView(title: document.title) {
        store.send(.didTapDocument(document))
      }
    }
  }
}
