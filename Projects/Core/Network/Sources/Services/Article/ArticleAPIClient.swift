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
  public var fetchArticles: @Sendable (_ request: ArticleSearchRequest) async throws -> [Article]
}

public extension DependencyValues {
  var articleAPIClient: ArticleAPIClient {
    get { self[ArticleAPIClient.self] }
    set { self[ArticleAPIClient.self] = newValue }
  }
}

extension ArticleAPIClient: DependencyKey {
  public static var liveValue: ArticleAPIClient = .init(
    fetchArticles: { reqeust in
      let api = ArticleAPI.fetchArticles(
        .init(
          categoryId: reqeust.category?.id,
          subcategoryId: reqeust.subcategory?.id,
          title: reqeust.title,
          sortBy: reqeust.sortBy?.rawValue
        )
      )
      let responseDTO: ArticlesResponseDTO = try await APIService<ArticleAPI>().request(api: api)
      return responseDTO.map(\.toEntity)
    }
  )
  
  public static var testValue: ArticleAPIClient = .init(
    fetchArticles: { _ in
      return Article.mockArticles
    }
  )
}
