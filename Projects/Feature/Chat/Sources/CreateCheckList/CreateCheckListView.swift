//
//  CreateCheckListView.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import SwiftUI

import CoreDomain

import ComposableArchitecture
import SharedDesignSystem

struct CreateCheckListView: View {
  @Bindable var navigationStore: StoreOf<ChatNavigationStore>
  @Bindable var store: StoreOf<CreateCheckListStore>
  
  var body: some View {
    VStack {
      TopNavigation(
        leadingItem: (Image.left, {
          navigationStore.send(.pop)
        }),
        centerTitle: "체크리스트"
      )
      
      
      ScrollView {
        ForEach(store.checkList, id: \.id) {
          CheckItem(store: store, item: $0)
        }
        ButtonSmall(title: "체크리스트 다시 생성하기", highLightTitle: "체크리스트", action: {
          store.send(.didTapReCreateButton)
        })
      }
      .padding(16)
      
      CommonButton(
        title: "저장하기",
        style: .default,
        isActive: true,
        action: {
          store.send(.didTapSaveButton)
          navigationStore.send(.enterKeyword(store.selectedCheckList))
        }
      )
      .padding(16)
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      store.send(.onAppear)
    }
  }
}

private struct CheckItem: View {
  @Bindable var store: StoreOf<CreateCheckListStore>
  @State private var isSelected: Bool = false
  private let item: CheckList
  
  init(store: StoreOf<CreateCheckListStore>, item: CheckList) {
    self.store = store
    self.item = item
  }
  
  var body: some View {
    DefaultChecklistCellView(isSelected: $isSelected, title: item.label)
      .onTapGesture {
        store.send(.didTapCheckList(item))
      }
  }
}
