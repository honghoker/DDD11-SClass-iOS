//
//  MainTabStore.swift
//  Feature
//
//  Created by 홍은표 on 7/31/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MainTabStore {
  public init() { }
  
  @ObservableState
  public struct State {
    public var selectedTab: MainTabItem
    
    public var home: HomeRootStore.State = .init()
    public var history: HistoryStore.State = .init()
    public var chat: ChatNavigationStore.State = .init()
    public var article: ArticleStore.State = .init()
    public var myPage: MyPageRootStore.State = .init()
    
    public var isSelectedChat = false
    
    public init(_ selectedTab: MainTabItem) {
      self.selectedTab = selectedTab
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case selectTab(MainTabItem)
    case home(HomeRootStore.Action)
    case history(HistoryStore.Action)
    case chat(ChatNavigationStore.Action)
    case article(ArticleStore.Action)
    case myPage(MyPageRootStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    
    Scope(state: \.chat, action: \.chat) {
      ChatNavigationStore()
    }
    
    Scope(state: \.home, action: \.home) {
      HomeRootStore()
    }
    
    Scope(state: \.history, action: \.history) {
      HistoryStore()
    }
    
    Scope(state: \.article, action: \.article) {
      ArticleStore()
    }
    
    Scope(state: \.myPage, action: \.myPage) {
      MyPageRootStore()
    }
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .selectTab(let tab):
        return changeSelectedTab(state: &state, tab: tab)
      case .home(.onPresentChat):
        return changeSelectedTab(state: &state, tab: .chat)
      case .home:
        return .none
      case .history:
        return .none
      case .article:
        return .none
      case .myPage:
        return .none
      case .chat(.chat(.onCloseView)):
        state.isSelectedChat = false
        state.selectedTab = .home
        return .none
      case .chat(.enterKeyword(.onCloseView(let checklist))):
        state.isSelectedChat = false
        state.selectedTab = .home
        return .send(.home(.onAppendChecklist(checklist: checklist)))
      case .chat:
        return .none
      }
    }
  }
  
  private func changeSelectedTab(state: inout State, tab: MainTabItem) -> Effect<Action> {
    if tab == .chat {
      state.isSelectedChat = true
      return .none
    }
    state.selectedTab = tab
    return .none
  }
}
