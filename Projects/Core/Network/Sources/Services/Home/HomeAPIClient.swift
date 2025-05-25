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
  public var fetchArticles: @Sendable(_ accessToken: String) async throws -> [MainArticle]
}

public extension DependencyValues {
  var homeAPIClient: HomeAPIClient {
    get { self[HomeAPIClient.self] }
    set { self[HomeAPIClient.self] = newValue }
  }
}

extension HomeAPIClient: DependencyKey {
  public static var liveValue: HomeAPIClient = .init(
    fetchArticles: { accessToken in
      let api = HomeAPI.fetchArticles(accessToken)
      let responseDTO: [MainArticleResponseDTO] = try await APIService<HomeAPI>().request(api: api)
      return responseDTO.map(\.toEntity)
    }
  )
}
