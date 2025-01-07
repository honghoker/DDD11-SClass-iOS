//
//  HistoryView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import SharedDesignSystem
import ComposableArchitecture
import CoreDomain


public struct HistoryView: View {
  @Bindable var store: StoreOf<HistoryStore>
  
  private let columns = [GridItem(spacing: 10), GridItem(spacing: 10)]
  
  public init(store: StoreOf<HistoryStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      VStack {
        TopNavigation(centerTitle: "나의 기록")
        content
      }
      .onAppear {
        store.send(.onAppear)
      }
      .historyAlert(
        isPresented: .init(
          get: { store.modal == .delete },
          set: { store.modal = $0 ? .delete : nil }
        ),
        title: "카테고리 삭제",
        description: "이 카테고리를 삭제하면 복구할 수 없어요. 그래도 삭제하시겠나요?",
        cancelText: "취소",
        confirmText: "삭제",
        onCancel: {
          store.send(.didTapDeleteCancel)
        },
        onSubmit: {
          store.send(.didTapDeleteConfirm)
        }
      )
      .sheet(item: $store.modal) { modal in
        switch modal {
        case .menu:
          CheckListBottomSheetView(store: store)
            .presentationDetents([.height(200)])
            .cornerRadius(20)
        case .editTitle:
          CheckListEditTitleBottomSheetView(store: store)
            .presentationDetents([.height(320)])
            .cornerRadius(20)
        case .delete:
          EmptyView()
        }
      }
    } destination: { store in
      switch store.case {
      case .historyDetail(let store):
        HistoryDetailView(store: store)
          .navigationBarBackButtonHidden()
      }
    }
  }
  
  private var content: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(store.state.checkList, id: \.id) { history in
          Button(action: {
            store.send(.didTapChecklist(history))
          }) {
            historyItem(history)
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private var emptyView: some View {
    Image.historyEmptyView
      .resizable()
      .scaledToFit()
      .frame(width: 192, height: 186)
  }
  
  @ViewBuilder
  private func historyItem(_ entity: Checklist) -> some View {
    VStack {
      HStack {
        Text("\(entity.checkBoxList.count)")
          .notoSans(.subhead_3)
          .foregroundColor(.greyScale950)
          .padding(10)
          .background(.greyScale0)
          .clipShape(Circle())
        
        Spacer()
        
        Button(action: {
          store.send(.didTapChecklistMenu(entity))
        }) {
          Group {
            if store.selected == entity {
              Image.check
            } else {
              Image.horizontal
            }
          }
		  .foregroundStyle(store.selected == entity ? .greyScale0 : .greyScale950)
        }
      }
      
      HStack {
        Text(entity.title ?? "-")
          .notoSans(.headline)
          .multilineTextAlignment(.leading)
          .frame(height: 56)
          .foregroundColor((store.selected == entity ? .greyScale0 : .greyScale950))
        Spacer()
      }
      
      HStack {
        Spacer()
        Text("1 day ago") // TODO: 수정
          .notoSans(.caption)
          .foregroundColor((store.selected == entity ? .greyScale0 : .greyScale500))
      }
    }
    .padding(16)
    .background(store.selected == entity ? .primary500 : .primary050)
    .aspectRatio(1, contentMode: .fill)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    
  }
}
