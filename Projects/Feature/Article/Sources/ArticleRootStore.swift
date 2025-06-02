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
    var articleSearchInput: ArticleSearchInputStore.State?

    public init() {}
  }

  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case path(StackActionOf<Path>)
    case article(ArticleStore.Action)
    case articleSearchInput(ArticleSearchInputStore.Action)
  }

  @Reducer
  public enum Path {
    case articleSearchInput(ArticleSearchInputStore)
  }

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .path(let action):
        return handlePathAction(state: &state, action: action)

      case .article(let action):
        switch action {
        case .onNaviagteToArticleSearchInput:
          state.path.append(.articleSearchInput(.init()))
          return .none

        default:
          return .none
        }

      case .articleSearchInput(let action):
        switch action {
        default:
          return .none
        }
      }
    }
    .forEach(\.path, action: \.path)
    .ifLet(\.articleSearchInput, action: \.articleSearchInput) {
      ArticleSearchInputStore()
    }

    Scope(state: \.article, action: \.article) {
      ArticleStore()
    }
  }

  private func handlePathAction(state: inout State, action: StackActionOf<Path>) -> Effect<Action> {
    switch action {
    case .element(id: _, action: .articleSearchInput(.didTapBackButton)):
      state.path.removeLast()
      return .none

    case .element(id: _, action: .articleSearchInput(.onSearchSubmit(let searchTerm))):
      // TODO: - 아티클 검색 결과 View로 이동
      return .none

    default:
      return .none
    }
  }
}
