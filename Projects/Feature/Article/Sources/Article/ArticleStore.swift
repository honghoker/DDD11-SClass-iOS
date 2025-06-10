//
//  ArticleStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import Foundation
import UIKit.UIPasteboard

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct ArticleStore {
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

  public struct SubcategorySheetState: Equatable {
    var isPresented: Bool = false
    @ObservationStateIgnored
    var category: ArticleCategory? = nil
    var subcategory: ArticleSubcategory? = nil
    var description: String {
      guard let subcategory else {
        return category?.title ?? ArticleCategory.all.headerTitle
      }

      if let category, subcategory == .all {
        return category.headerTitle
      }

      return subcategory.rawValue
    }

    public mutating func present(
      category: ArticleCategory,
      previousSubcategory subcategory: ArticleSubcategory?
    ) {
      self.category = category
      self.subcategory = subcategory
      self.isPresented = true
    }

    public mutating func dismiss() {
      category = nil
      subcategory = nil
      isPresented = false
    }
  }

  @ObservableState
  public struct State {
    var isFetching: Bool = true
    let categories: [ArticleCategory] = ArticleCategory.allCases
    var articleHeaderTitle: String = ArticleCategory.all.headerTitle
    var articles: IdentifiedArrayOf<Article> = []

    var selectedCategory: ArticleCategory = .all
    @ObservationStateIgnored
    var selectedSubcategory: ArticleSubcategory? = nil
    var subcategorySheet: SubcategorySheetState = .init()

    var selectedArticle: Article? = nil

    var shareContextMenu: ContextMenuState = .init()
    @ObservationStateIgnored
    var selectedShareArticleId: Int? = nil

    var sortContextMenu: ContextMenuState = .init()
    var sortType: ArticleSortType = .latest

    var isShareSheetPresented: Bool = false
    @ObservationStateIgnored
    var shareURL: URL? = nil

    public init() {}
  }

  public enum Action: BindableAction {

    // MARK: - Life Cycle

    case onAppear

    // MARK: - View

    case binding(BindingAction<State>)
    case presentSubcategorySheet(ArticleCategory)

    // MARK: - User Actions

    case didTapCategoryButton(ArticleCategory)
    case didCloseSubcategorySheet
    case didTapMenuButton(articleId: Int, globalFrame: CGRect)
    case didTapOutsidePopup
    case didTapShareButton
    case didTapCopyLinkButton
    case didDismissShareSheet
    case didTapArticle(article: Article)
    case didTapArticleExitButton
    case didTapSearchButton
    case didTapSortPopupButton(globalFrame: CGRect)
    case didTapSortButton(ArticleSortType)
    case didTapSubcategoryButton(ArticleSubcategory)

    // MARK: - Async Action

    case fetchArticles

    // MARK: - Internal Actions

    case onCompleteFetchArticles(Result<[Article], Error>)

    // MARK: - Delegate Actions(parent)

    case onNaviagteToArticleSearchInput
  }

  // MARK: - Dependencies

  @Dependency(ArticleAPIClient.self) private var articleAPIClient

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .send(.fetchArticles)

      case .fetchArticles:
        let request: ArticleSearchRequest = .init(
          category: state.selectedCategory,
          subcategory: state.selectedSubcategory,
          sortBy: state.sortType
        )

        return .run { send in
          await send(.onCompleteFetchArticles(
            Result {
              try await articleAPIClient.fetchArticles(request: request)
            }
          ))
        }

      case .onCompleteFetchArticles(let result):
        switch result {
        case .success(let articles):
          state.articles = .init(uniqueElements: articles)
        case .failure(let error):
          debugPrint("Article Search Error: \(error)")
        }
        state.isFetching = false
        return .none

      case .didTapCategoryButton(let category):
        if category == .all {
          state.selectedCategory = category
          state.selectedSubcategory = nil
          state.articleHeaderTitle = category.headerTitle
          return .none
        }

        return .send(.presentSubcategorySheet(category))

      case .didCloseSubcategorySheet:
        defer {
          state.subcategorySheet.dismiss()
        }

        guard let category = state.subcategorySheet.category,
              let subcategory = state.subcategorySheet.subcategory
        else {
          return .none
        }

        state.selectedCategory = category
        state.selectedSubcategory = subcategory
        state.articleHeaderTitle = state.subcategorySheet.description
        return .send(.fetchArticles)

      case .presentSubcategorySheet(let category):
        let previousSubcategory: ArticleSubcategory?
        if state.selectedCategory == category {
          previousSubcategory = state.selectedSubcategory
        } else {
          previousSubcategory = nil
        }

        state.subcategorySheet.present(category: category, previousSubcategory: previousSubcategory)
        return .none

      case .didTapSubcategoryButton(let subcategory):
        state.subcategorySheet.subcategory = subcategory
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

        if state.sortContextMenu.isPresented {
          state.sortContextMenu.dismiss()
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

      case .didTapSearchButton:
        return .send(.onNaviagteToArticleSearchInput)

      case .didTapSortPopupButton(let globalFrame):
        if state.sortContextMenu.isPresented {
          state.sortContextMenu.dismiss()
        } else {
          state.sortContextMenu.show(anchorFrame: globalFrame)
        }
        return .none

      case .didTapSortButton(let sortType):
        state.sortContextMenu.dismiss()
        guard state.sortType != sortType else {
          return .none
        }
        state.sortType = sortType
        return .send(.fetchArticles)

      default:
        return .none
      }
    }
  }
}
