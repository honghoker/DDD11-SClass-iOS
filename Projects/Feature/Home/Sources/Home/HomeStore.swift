//
//  HomeStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct HomeStore {
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    var articles: [Article] = []
    var selectedArticle: Article?
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case didTapAppendFolderButton
    case onPresentChat
    case fetchArticles(TaskResult<[Article]>)
    case didTapArticle(Article)
    case didTapArticleExitButton
  }
  
  public init() {}
  
  @Dependency(HomeAPIClient.self) var homeAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .onAppear:
        guard let userID = state.userInfo?.userID else { 
          return .none
        }
        
        return .run { send in
          await send(.fetchArticles(
            TaskResult {
              try await homeAPIClient.fetchArticles(userID)
            }
          ))
        }
      case .didTapAppendFolderButton:
        return .send(.onPresentChat)
      case .fetchArticles(.success(let aritlces)):
        state.articles = Array(aritlces.prefix(3))
        return .none
      case .fetchArticles(.failure(let error)):
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
