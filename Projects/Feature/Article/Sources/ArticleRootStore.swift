//
//  ArticleRootStore.swift
//  FeatureArticle
//
//  Created by 홍은표 on 7/31/24.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ArticleRootStore {
  public init() {}

  @ObservableState
  public struct State {
    var path = StackState<Path.State>()
    var article: ArticleStore.State = .init()
    var searchArticle: SearchArticleStore.State?

    public init() {

    }
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case path(StackActionOf<Path>)
    case article(ArticleStore.Action)
    case searchArticle(SearchArticleStore.Action)
  }

  @Reducer
  public enum Path {
    case searchArticle(SearchArticleStore)
  }

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case let .path(action):
        return .none

      case let .article(action):
        switch action {
        case .onNaviagteToSearchArticle:
          state.path.append(.searchArticle(.init()))
          return .none

        default:
          return .none
        }

      case let .searchArticle(action):
        return .none
      }
    }
    .forEach(\.path, action: \.path)
    .ifLet(\.searchArticle, action: \.searchArticle) {
      SearchArticleStore()
    }

    Scope(state: \.article, action: \.article) {
      ArticleStore()
    }
  }
}
