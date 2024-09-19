//
//  HomeAPIClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public struct HomeAPIClient: Sendable {
  public var fetchArticles: @Sendable(_ userID: String) async throws -> [Article]
}

public extension DependencyValues {
  var homeAPIClient: HomeAPIClient {
    get { self[HomeAPIClient.self] }
    set { self[HomeAPIClient.self] = newValue }
  }
}

extension HomeAPIClient: DependencyKey {
  public static var liveValue: HomeAPIClient = .init(
    fetchArticles: { userID in
      let api = HomeAPI.fetchArticles(userID)
      let responseDTO: ArticlesResponseDTO = try await APIService<HomeAPI>().request(api: api)
      return responseDTO.articles.map(\.toEntity)
    }
  )
}
