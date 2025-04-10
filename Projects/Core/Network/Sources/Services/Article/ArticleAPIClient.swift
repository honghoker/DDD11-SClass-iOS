//
//  ArticleAPIClient.swift
//  CoreNetwork
//
//  Created by eunpyo on 4/4/25.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public struct ArticleAPIClient: Sendable {
  @DependencyEndpoint
  public var fetchArticles: @Sendable () async throws -> [Article]
}

public extension DependencyValues {
  var articleAPIClient: ArticleAPIClient {
    get { self[ArticleAPIClient.self] }
    set { self[ArticleAPIClient.self] = newValue }
  }
}

extension ArticleAPIClient: DependencyKey {
  public static var liveValue: ArticleAPIClient = .init(
    fetchArticles: {
      let api = ArticleAPI.fetchArticles
      let responseDTO: ArticlesResponseDTO = try await APIService<ArticleAPI>().request(api: api)
      return responseDTO.articles.map(\.toEntity)
    }
  )
  
  public static var testValue: ArticleAPIClient = .init(
    fetchArticles: {
      return Article.mockArticles
    }
  )
}
