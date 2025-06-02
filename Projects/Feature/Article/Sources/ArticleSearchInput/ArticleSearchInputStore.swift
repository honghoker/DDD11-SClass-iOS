//
//  ArticleSearchInputStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 4/23/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

@Reducer
public struct ArticleSearchInputStore {
  public init() {}

  @ObservableState
  public struct State {
    var searchTerm: String = ""
    @Shared(.searchTerms) public var recentSearchTerms: [String] = ["WEB UI", "ID", "TEST"]

    public init() {}
  }

  public enum Action: BindableAction {
    // MARK: - Life Cycle

    case onAppear

    // MARK: - View

    case binding(BindingAction<State>)

    // MARK: - User Actions

    case didTapBackButton
    case didSubmit
    case didTapClearSearchTerm
    case didTapRecentSearchTerm(String)
    case didTapRemoveRecentSearchTermButton(String)
    case didTapClearRecentSearchTermButton

    // MARK: - Internal Actions

    case addRecentSearchTerm(String)
    case removeRecentSearchTerm(String)
    case clearAllRecentSearchTerms
    case submit(String)

    // MARK: - Delegate Actions(parent)

    case onSearchSubmit(String)
  }

  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .onAppear:
        return .none

      case .didTapBackButton:
        return .none

      case .didSubmit:
        return .send(.submit(state.searchTerm))

      case .didTapClearSearchTerm:
        state.searchTerm = ""
        return .none

      case .didTapRecentSearchTerm(let searchTerm):
        return .send(.submit(searchTerm))

      case .submit(let searchTerm):
        return .merge(
          .send(.addRecentSearchTerm(searchTerm)),
          .send(.onSearchSubmit(searchTerm))
        )

      case .didTapRemoveRecentSearchTermButton(let searchTerm):
        return .send(.removeRecentSearchTerm(searchTerm))

      case .didTapClearRecentSearchTermButton:
        return .send(.clearAllRecentSearchTerms)

      case .addRecentSearchTerm(let searchTerm):
        let trimmedTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTerm.isEmpty else {
          return .none
        }

        // 기존 검색어가 있다면 제거
        state.recentSearchTerms.removeAll { $0 == trimmedTerm }
        
        // 맨 앞에 추가
        state.recentSearchTerms.insert(trimmedTerm, at: 0)

        return .none
        
      case .removeRecentSearchTerm(let searchTerm):
        state.recentSearchTerms.removeAll { $0 == searchTerm }
        return .none
        
      case .clearAllRecentSearchTerms:
        state.recentSearchTerms.removeAll()
        return .none

      default:
        return .none
      }
    }
  }
}
