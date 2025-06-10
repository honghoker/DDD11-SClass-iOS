//
//  ArticleSearchResultsStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 6/3/25.
//

import Foundation
import UIKit.UIPasteboard

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct ArticleSearchResultsStore {
  public init() {}

  public struct ContextMenuState: Equatable {
    public var isPresented: Bool = false
    @ObservationStateIgnored
    public var anchorFrame: CGRect? = nil

    public init() {}

    public mutating func show(anchorFrame: CGRect) {
      self.anchorFrame = anchorFrame
      self.isPresented = true
    }

    public mutating func dismiss() {
      self.anchorFrame = nil
      self.isPresented = false
    }
  }

  @ObservableState
  public struct State {
    let searchTerms: String
    var isFetching: Bool = true

    var articles: IdentifiedArrayOf<Article> = []

    var selectedArticle: Article? = nil

    var shareContextMenu: ContextMenuState = .init()
    @ObservationStateIgnored
    var selectedShareArticleId: Int? = nil

    var isShareSheetPresented: Bool = false
    @ObservationStateIgnored
    var shareURL: URL? = nil

    public init(searchTerms: String) {
      self.searchTerms = searchTerms
    }
  }

  public enum Action: BindableAction {
    // MARK: - Life Cycle

    case onAppear

    // MARK: - View

    case binding(BindingAction<State>)

    // MARK: - User Actions

    case didTapBackButton
    case didTapMenuButton(articleId: Int, globalFrame: CGRect)
    case didTapOutsidePopup
    case didTapShareButton
    case didTapCopyLinkButton
    case didDismissShareSheet
    case didTapArticle(article: Article)
    case didTapArticleExitButton

    // MARK: - Internal Actions

    case onCompleteFetchArticles(Result<[Article], Error>)
  }

  // MARK: - Dependencies

  @Dependency(ArticleAPIClient.self) private var articleAPIClient
  @Dependency(\.continuousClock) private var clock

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {

      case .onAppear:
        return .run { [searchTerms = state.searchTerms] send in
          let request: ArticleSearchRequest = .init(title: searchTerms)

          try? await clock.sleep(for: .seconds(0.5))
          await send(.onCompleteFetchArticles(
            Result {
              try await articleAPIClient.fetchArticles(request: request)
            }
          ))
        }

      case .binding:
        return .none

      case .didTapBackButton:
        return .none

      case .didTapMenuButton(let articleId, let globalFrame):
        if state.selectedShareArticleId == articleId {
          state.selectedShareArticleId = nil
          state.shareContextMenu.dismiss()
        } else {
          state.selectedShareArticleId = articleId
          state.shareContextMenu.show(anchorFrame: globalFrame)
        }
        return .none

      case .didTapOutsidePopup:
        if state.shareContextMenu.isPresented {
          state.shareContextMenu.dismiss()
          state.selectedShareArticleId = nil
        }

        return .none

      case .didTapShareButton:
        guard let articleId = state.selectedShareArticleId,
              let article = state.articles[id: articleId],
              let url = URL(string: article.url)
        else {
          return .none
        }

        state.selectedShareArticleId = nil
        state.shareURL = url
        state.shareContextMenu.dismiss()
        state.isShareSheetPresented = true
        return .none

      case .didTapCopyLinkButton:
        guard let articleId = state.selectedShareArticleId,
              let article = state.articles[id: articleId]
        else {
          return .none
        }

        state.selectedShareArticleId = nil
        UIPasteboard.general.string = article.url
        state.shareContextMenu.dismiss()
        return .none

      case .didDismissShareSheet:
        state.isShareSheetPresented = false
        state.shareURL = nil
        return .none

      case .didTapArticle(let article):
        state.selectedArticle = article
        return .none

      case .didTapArticleExitButton:
        state.selectedArticle = .none
        return .none

      case .onCompleteFetchArticles(let result):
        switch result {
        case .success(let articles):
          state.articles = .init(uniqueElements: articles)
        case .failure(let error):
          debugPrint("Article Search Error: \(error)")
        }
        state.isFetching = false
        return .none
      }
    }
  }
}
