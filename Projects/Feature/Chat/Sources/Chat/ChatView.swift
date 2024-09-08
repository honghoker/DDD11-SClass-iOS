//
//  base.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/13
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem

public struct ChatView: View {
  @Bindable var navigationStore: StoreOf<ChatNavigationStore>
  @Bindable var store: StoreOf<ChatStore>
  
  @FocusState var isFocused: Bool
  @State private var isOpacity: Bool = false
  
  public init(store: StoreOf<ChatNavigationStore>) {
    self.navigationStore = store
    store.send(.initializeChat)
    self.store =  store.scope(state: \.chat, action: \.chat)
  }
  
  public var body: some View {
    NavigationStack(path: $navigationStore.scope(state: \.path, action: \.path)) {
      VStack {
        TopNavigation(
          leadingItem: (Image.closeCross, {
            store.send(.didTapExitButton)
          }),
          centerTitle: "프로젝트 추가"
        )
        content()
          .padding(16)
      }
    } destination: { store in
      switch store.case {
      case .createCheckList(let store):
        CreateCheckListView(navigationStore: navigationStore, store: store)
      case .enterKeyword(let store):
        EnterKeywordView(store: store, navigationStore: navigationStore)
      }
    }
    .opacity(isOpacity ? 1 : 0)
    .onAppear {
      store.send(.onAppear)
      withAnimation(.easeOut(duration: 0.3)) {
        isOpacity = true
      }
    }
    .onDisappear {
      withAnimation(.easeOut(duration: 0.3)) {
        isOpacity = false
      }
    }
    .historyAlert(
      isPresented: $store.isPresented,
      title: "채팅에서 나가기",
      description: "채팅방을 나가면 지금까지 작성한 기록을 복구할 수 없어요.",
      cancelText: "취소",
      confirmText: "나가기",
      onCancel: {
        store.send(.didTapExitCancelButton)
      },
      onSubmit: {
        store.send(.didTapExitConfirmButton)
      }
    )
    
  }
  
  @ViewBuilder
  func content() -> some View {
    VStack {
      ScrollView {
        ZStack {
          placeholderView
          chattingView
        }
      }
      .frame(maxWidth: .infinity)
      inputView
    }
  }
  
  private var placeholderView: some View {
    VStack {
      Spacer(minLength: 200)
      Image.chatPlaceholder
        .resizable()
        .scaledToFit()
        .foregroundStyle(.greyScale050)
        .frame(width: 43)
      Spacer()
    }
  }
  
  private var chattingView: some View {
    VStack {
      ForEach(store.chatList, id: \.title) { message in
        MessageBubbleView(
          type: message.type,
          title: message.title,
          content: message.content
        )
        .if(message.type == .info) {
          $0.onTapGesture {
            store.send(.didTapCreateCheckListButton(message))
          }
        }
      }
      Spacer()
    }
  }
  
  
  private var inputView: some View {
    VStack {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 0) {
          ForEach(1..<5) { i in
            PromptExampleView(title: "디자인 체크리스트 예시 \(i)", content: "디자인할 때 체크해야할 리스트") {
              store.send(.didTapExmapleButton)
            }
          }
        }
      }
      
      ChatInputView(
        text: $store.chatMessage,
        action: {
          store.send(.didTapSendButton)
        },
        isFocused: $isFocused
      )
      .focused($isFocused)
    }
  }
}
