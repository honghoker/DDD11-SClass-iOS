//
//  SearchArticleStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 4/23/25.
//

import Foundation

import ComposableArchitecture

@Reducer
public struct SearchArticleStore {
  public init() {}

  @ObservableState
  public struct State {
    public init() {}
  }

  public enum Action: BindableAction {
    // MARK: - Life Cycle

    case onAppear

    // MARK: - View

    case binding(BindingAction<State>)
  }

  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .onAppear:
        return .none
      }
    }
  }
}
