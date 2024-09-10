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
    
    public var home: HomeStore.State = .init()
    public var history: HistoryStore.State = .init()
    public var chat: ChatStore.State = .init()
    public var article: ArticleStore.State = .init()
    public var myPage: MyPageRootStore.State = .init()
    
    public init(_ selectedTab: MainTabItem) {
      self.selectedTab = selectedTab
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case selectTab(MainTabItem)
    case home(HomeStore.Action)
    case history(HistoryStore.Action)
    case chat(ChatStore.Action)
    case article(ArticleStore.Action)
    case myPage(MyPageRootStore.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .selectTab(let tab):
        state.selectedTab = tab
        return .none
      case .home:
        return .none
      case .history:
        return .none
      case .chat:
        return .none
      case .article:
        return .none
      case .myPage:
        return .none
      }
    }
    
    Scope(state: \.home, action: \.home) {
      HomeStore()
    }
    
    Scope(state: \.history, action: \.history) {
      HistoryStore()
    }
    
    Scope(state: \.chat, action: \.chat) {
      ChatStore()
    }
    
    Scope(state: \.article, action: \.article) {
      ArticleStore()
    }
    
    Scope(state: \.myPage, action: \.myPage) {
      MyPageRootStore()
    }
  }
}
