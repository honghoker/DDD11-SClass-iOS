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
    
    public var home: HomeRootStore.State?
    public var history: HistoryStore.State?
    public var chat: ChatNavigationStore.State = .init()
    public var article: ArticleRootStore.State?
    public var myPage: MyPageRootStore.State?
    
    public var isSelectedChat = false
    
    public init(_ selectedTab: MainTabItem) {
      self.selectedTab = selectedTab
    }
  }
  
  public enum Action: BindableAction {
    case onAppear
    case binding(BindingAction<State>)
    case selectTab(MainTabItem)
    case home(HomeRootStore.Action)
    case history(HistoryStore.Action)
    case chat(ChatNavigationStore.Action)
    case article(ArticleRootStore.Action)
    case myPage(MyPageRootStore.Action)
    case routeToLoginPage
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return changeSelectedTab(state: &state, tab: state.selectedTab)

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

      case .myPage(.navigateToLoginPage):
        return .send(.routeToLoginPage)
        
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
        
      default:
        return .none
      }
    }
    .ifLet(\.home, action: \.home) {
      HomeRootStore()
    }
    .ifLet(\.history, action: \.history) {
      HistoryStore()
    }
    .ifLet(\.article, action: \.article) {
      ArticleRootStore()
    }
    .ifLet(\.myPage, action: \.myPage) {
      MyPageRootStore()
    }

    Scope(state: \.chat, action: \.chat) {
      ChatNavigationStore()
    }
  }
  
  private func changeSelectedTab(state: inout State, tab: MainTabItem) -> Effect<Action> {

    switch tab {
    case .home:
      if state.home == nil { state.home = .init() }
    case .history:
      if state.history == nil { state.history = .init() }
    case .chat:
      state.isSelectedChat = true
      return .none
    case .article:
      if state.article == nil { state.article = .init() }
    case .myPage:
      if state.myPage == nil { state.myPage = .init() }
    }

    state.selectedTab = tab
    return .none
  }
}
