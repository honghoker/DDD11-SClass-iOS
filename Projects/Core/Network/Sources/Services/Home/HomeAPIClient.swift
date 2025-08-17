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
  public var fetchArticles: @Sendable() async throws -> [MainArticle]
  public var fetchChecklistsStatus: @Sendable() async throws -> [MainChecklistsStatus]
}

public extension DependencyValues {
  var homeAPIClient: HomeAPIClient {
    get { self[HomeAPIClient.self] }
    set { self[HomeAPIClient.self] = newValue }
  }
}

extension HomeAPIClient: DependencyKey {
  public static var liveValue: HomeAPIClient = .init(
    fetchArticles: {
      let api = HomeAPI.fetchArticles
      let responseDTO: [MainArticleResponseDTO] = try await APIService<HomeAPI>().request(api: api)
      return responseDTO.map(\.toEntity)
    },
    fetchChecklistsStatus: {
      let api = HomeAPI.fetchChecklistsStatus
      let responseDTO: [MainChecklistsStatusResponseDTO] = try await APIService<HomeAPI>().request(api: api)
      return responseDTO.map(\.toEntity)
    }
  )
}
