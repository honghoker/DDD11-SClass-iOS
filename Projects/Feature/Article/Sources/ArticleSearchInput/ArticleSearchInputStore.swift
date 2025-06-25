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
    @Shared(.searchTerms) public var recentSearchTerms: [String] = []

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
    case didChangeSearchTerm
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

  @Dependency(\.continuousClock) private var clock

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
        guard !state.searchTerm.isEmpty else {
          return .none
        }

        return .send(.submit(state.searchTerm))

      case .didTapClearSearchTerm:
        state.searchTerm = ""
        return .none

      case .didTapRecentSearchTerm(let searchTerm):
        return .send(.submit(searchTerm))

      case .submit(let searchTerm):
        return .merge(
          .run { send in
            try? await clock.sleep(for: .seconds(0.5))
            await send(.addRecentSearchTerm(searchTerm))
          },
          .send(.onSearchSubmit(searchTerm))
        )

      case .didChangeSearchTerm:
        let searchTerm = state.searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        guard state.searchTerm != searchTerm else {
          return .none
        }
        state.searchTerm = searchTerm
        return .none

      case .didTapRemoveRecentSearchTermButton(let searchTerm):
        return .send(.removeRecentSearchTerm(searchTerm))

      case .didTapClearRecentSearchTermButton:
        return .send(.clearAllRecentSearchTerms)

      case .addRecentSearchTerm(let searchTerm):
        let trimmedTerm = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTerm.isEmpty else {
          return .none
        }

        var searchTerms = state.recentSearchTerms
        // 기존 검색어가 있다면 제거
        searchTerms.removeAll { $0 == trimmedTerm }
        // 맨 앞에 추가
        searchTerms.insert(trimmedTerm, at: 0)
        state.recentSearchTerms = searchTerms

        return .none

      case .removeRecentSearchTerm(let searchTerm):
        var searchTerms = state.recentSearchTerms
        searchTerms.removeAll { $0 == searchTerm }
        state.recentSearchTerms = searchTerms
        return .none
        
      case .clearAllRecentSearchTerms:
        var searchTerms = state.recentSearchTerms
        searchTerms.removeAll()
        state.recentSearchTerms = searchTerms
        return .none

      default:
        return .none
      }
    }
  }
}
