//
//  MainTabView.swift
//  Feature
//
//  Created by 홍은표 on 7/31/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct MainTabView: View {
  private let store: StoreOf<MainTabStore>
  
  public init(store: StoreOf<MainTabStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      TabView(store: store)
      TabBarView(store: store)
    }
  }
}

private struct TabView: View {
  @Bindable private var store: StoreOf<MainTabStore>
  
  fileprivate init(store: StoreOf<MainTabStore>) {
    self.store = store
  }
  
  fileprivate var body: some View {
    switch store.selectedTab {
    case .home:
      HomeView(store: store.scope(state: \.home, action: \.home))
    case .history:
      HistoryView(store: store.scope(state: \.history, action: \.history))
    case .chat:
      ChatView(store: store.scope(state: \.chat, action: \.chat))
    case .article:
      ArticleView(store: store.scope(state: \.article, action: \.article))
    case .myPage:
      MyPageRootView(store: store.scope(state: \.myPage, action: \.myPage))
    }
  }
}

private struct TabBarView: View {
  @Bindable private var store: StoreOf<MainTabStore>
  
  fileprivate init(store: StoreOf<MainTabStore>) {
    self.store = store
  }
  
  fileprivate var body: some View {
    ZStack {
      HStack(alignment: .bottom, spacing: 30) {
        HStack(spacing: 22) {
          TabItem(store: store, type: .home)
          TabItem(store: store, type: .history)
        }
        CircleTabItem(store: store)
        HStack(spacing: 22) {
          TabItem(store: store, type: .article)
          TabItem(store: store, type: .myPage)
        }
      }
      .padding(.horizontal, 16)
      .frame(maxWidth: .infinity)
      .frame(height: 64)
      .overlay(alignment: .top) {
        Rectangle()
          .frame(height: 1)
          .foregroundStyle(.greyScale050)
      }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 64)
  }
}

private struct TabItem: View {
  @Bindable private var store: StoreOf<MainTabStore>
  private let type: MainTabItem
  
  fileprivate init(
    store: StoreOf<MainTabStore>,
    type: MainTabItem
  ) {
    self.store = store
    self.type = type
  }
  
  fileprivate var body: some View {
    TabBarItemView(
      image: type.image,
      title: type.title,
      isSelected: type == store.selectedTab
    )
    .onTap {
      store.send(.selectTab(type))
    }
  }
}

private struct CircleTabItem: View {
  @Bindable private var store: StoreOf<MainTabStore>
  
  fileprivate init(store: StoreOf<MainTabStore>) {
    self.store = store
  }
  
  fileprivate var body: some View {
    TabBarItemCircleView(image: MainTabItem.chat.image)
      .onTap {
        // TODO: - chat view navigate
      }
      .padding(.bottom, 11)
  }
}
