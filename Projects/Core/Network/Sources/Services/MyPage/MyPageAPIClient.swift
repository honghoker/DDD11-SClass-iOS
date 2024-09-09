//
//  MyPageAPIClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/10/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import Moya

@DependencyClient
public struct MyPageAPIClient {
  public var fetchUser: @Sendable(_ userID: String) async throws -> UserInfo
}

public extension DependencyValues {
  var myPageAPIClient: MyPageAPIClient {
    get { self[MyPageAPIClient.self] }
    set { self[MyPageAPIClient.self] = newValue }
  }
}

extension MyPageAPIClient: DependencyKey {
  public static var liveValue: MyPageAPIClient = .init(
    fetchUser: { userID in
      let api = MyPageAPI.fetchUser(userID)
      let responseDTO: UserInfoResponseDTO = try await APIService<MyPageAPI>().request(api: api)
      return responseDTO.toDomain()
    }
  )
}
