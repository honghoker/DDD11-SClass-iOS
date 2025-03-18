//
//  ArticleStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

@Reducer
public struct ArticleStore {
  public init() {}

  @ObservableState
  public struct State {
    let categories: [ArticleCategory] = ArticleCategory.allCases
    var selectedCategory: ArticleCategory = .all

    public init() {}
  }

  public enum Action: BindableAction {

    // MARK: - View

    case binding(BindingAction<State>)

    // MARK: - User Actions

    case didTapCategoryButton(ArticleCategory)
  }

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapCategoryButton(let category):
        // TODO: - 세부 직무 선택 바텀 시트 표시
        state.selectedCategory = category
        return .none

      default:
        return .none
      }
    }
  }
}
