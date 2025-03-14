//
//  ArticleStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct ArticleStore {
  public init() {}

  @ObservableState
  public struct State {
    public init() {

    }
  }

  public enum Action {

  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
}
