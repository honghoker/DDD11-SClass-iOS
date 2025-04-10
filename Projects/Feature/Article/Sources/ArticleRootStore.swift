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
    var article: ArticleStore.State = .init()

    public init() {

    }
  }

  public enum Action {
    case article(ArticleStore.Action)
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }

    Scope(state: \.article, action: \.article) {
      ArticleStore()
    }
  }
}
