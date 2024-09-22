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
  public var getCheckLists: @Sendable(_ userID: String) async throws -> [CheckList]
  public var getCheckList: @Sendable(_ id: String) async throws -> CheckList
  public var deleteChecklist: @Sendable(_ checkListId: String) async throws -> Void
  public var deleteCheckList: @Sendable(_ checkListId: String, _ checkBoxList: [String]) async throws -> [String]
  public var changeKeyword: @Sendable(_ checkListId: String, _ newKeyword: String) async throws -> Void
  public var complete: @Sendable(_ checklistId: String, _ id: String) async throws -> Void
}

public extension DependencyValues {
  var checkListAPIClient: CheckListAPIClient {
    get { self[CheckListAPIClient.self] }
    set { self[CheckListAPIClient.self] = newValue }
  }
}

extension CheckListAPIClient: DependencyKey {
  public static var liveValue: CheckListAPIClient = .init(
    getCheckLists: { userID in
      let api = CheckListAPI.getCheckLists(userID: userID)
      let responseDTO: ChecklistsResponseDTO = try await APIService<CheckListAPI>().request(api: api)
      return responseDTO.checklists.map { $0.toEntity }
    },
    getCheckList: { id in
      let api = CheckListAPI.getCheckList(id: id)
      let responseDTO: CheckListResponseDTO = try await APIService<CheckListAPI>().request(api: api)
      return responseDTO.toEntity
    },
    deleteChecklist: { checklistId in
      let api = CheckListAPI.deleteChecklist(checklistId: checklistId)
      let responseDTO: EmptyResponseDTO = try await APIService<CheckListAPI>().request(api: api)
    },
    deleteCheckList: { checkListId, checkBox in
      let api = CheckListAPI.deleteCheckList(checkListId: checkListId, checkBoxList: checkBox)
      let responseDTO: DeleteCheckListResponseDTO = try await APIService<CheckListAPI>().request(api: api)
      return responseDTO.deletedIds
    },
    changeKeyword: { checkListId, title in
      let api = CheckListAPI.changeKeyword(checkListId: checkListId, newKeyword: title)
      let responseDTO: EmptyResponseDTO = try await APIService<CheckListAPI>().request(api: api)
    },
    complete: { checklistId, id in
      let api = CheckListAPI.complete(checklistId: checklistId, id: id)
      let responseDTO: EmptyResponseDTO = try await APIService<CheckListAPI>().request(api: api)
    }
  )
  
  public static var testValue: CheckListAPIClient = Self()
}
