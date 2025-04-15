//
//  ArticleStore.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import Foundation
import UIKit

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct ArticleStore {
  
  public init() {}

  public struct ContextMenu {
    private let size: CGSize = .init(width: 140, height: 92)
    private(set) var isPresented: Bool = false
    @ObservationStateIgnored
    private(set) var openedArticleId: Int?
    @ObservationStateIgnored
    private(set) var position: CGPoint = .zero

    public init() {}

    mutating func show(articleId: Int, in globalFrame: CGRect) {
      let position: CGPoint = .init(
        x: globalFrame.maxX - (size.width / 2),
        y: globalFrame.minY - size.height - 12
      )
      openedArticleId = articleId
      self.position = position
      isPresented = true
    }
    
    mutating func dismiss() {
      openedArticleId = nil
      position = .zero
      isPresented = false
    }
  }
  
  @ObservableState
  public struct State {
    let categories: [ArticleCategory] = ArticleCategory.allCases
    var articleHeaderTitle: String = "🔥 인기 아티클"
    var articles: IdentifiedArrayOf<Article> = []
    var selectedCategory: ArticleCategory = .all
    var selectedArticle: Article? = nil

    var contextMenu: ContextMenu = .init()

    /// 공유
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
    
    // MARK: - User Actions
    
    case didTapCategoryButton(ArticleCategory)
    case didTapMenuButton(articleId: Int, globalFrame: CGRect)
    case didTapOutsidePopup
    case didTapShareButton
    case didTapCopyLinkButton
    case didDismissShareSheet
    case didTapArticle(article: Article)
    case didTapArticleExitButton

    case onCompleteFetchArticles(Result<[Article], Never>)
  }
  
  // MARK: - Dependencies
  
  @Dependency(ArticleAPIClient.self) private var articleAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        return .run { send in
          do {
            try await withDependencies {
              // FIXME: - API 연동 후 코드 제거
              $0.articleAPIClient = .testValue
            } operation: {
              let articles = try await articleAPIClient.fetchArticles()
              await send(.onCompleteFetchArticles(.success(articles)))
            }
          } catch {
            debugPrint("@@@@@ fetch Article Error: \(error)")
          }
        }
        
      case .onCompleteFetchArticles(let result):
        switch result {
        case .success(let articles):
          state.articles = .init(uniqueElements: articles)
        }
        return .none
        
      case .didTapCategoryButton(let category):
        // TODO: - 세부 직무 선택 바텀 시트 표시
        state.selectedCategory = category
        return .none
        
      case .didTapMenuButton(let articleId, let globalFrame):
        if state.contextMenu.openedArticleId == articleId {
          state.contextMenu.dismiss()
        } else {
          state.contextMenu.show(articleId: articleId, in: globalFrame)
        }
        return .none
        
      case .didTapOutsidePopup:
        state.contextMenu.dismiss()
        return .none
        
      case .didTapShareButton:
        guard let id = state.contextMenu.openedArticleId else {
          return .none
        }
        
        guard
          let article = state.articles[id: id],
          let url = URL(string: article.url)
        else {
          return .none
        }
        
        state.shareURL = url
        state.contextMenu.dismiss()
        state.isShareSheetPresented = true
        return .none
        
      case .didTapCopyLinkButton:
        guard
          let id = state.contextMenu.openedArticleId,
          let article = state.articles[id: id]
        else {
          return .none
        }
        
        UIPasteboard.general.string = article.url
        state.contextMenu.dismiss()
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

      default:
        return .none
      }
    }
  }
}
