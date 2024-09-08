//
//  CheckListAPIClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Combine
import CombineMoya
import ComposableArchitecture
import Moya

@DependencyClient
public struct CheckListAPIClient: Sendable {
  public var getCheckList: @Sendable(_ id: String) async throws -> [CheckList]
}

public extension DependencyValues {
  var checkListAPIClient: CheckListAPIClient {
    get { self[CheckListAPIClient.self] }
    set { self[CheckListAPIClient.self] = newValue }
  }
}

extension CheckListAPIClient: DependencyKey {
  public static var liveValue: CheckListAPIClient = .init(
    getCheckList: { id in
      let api = CheckListAPI.getCheckList(id: id)
      let responseDTO: CheckListDTO = try await APIService<CheckListAPI>().request(api: api)
      
      return responseDTO.checkboxes.map { $0.toEntity }
    }
  )
  
  public static var testValue: CheckListAPIClient = Self()
}
