//
//  ChecklistAPIClient.swift
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
public struct ChecklistAPIClient: Sendable {
  public var getChecklists: @Sendable() async throws -> [Checklist]
  public var getChecklistItemList: @Sendable(_ id: String) async throws -> [CheckBox]
    
  public var getDraftChecklist: @Sendable(_ id: String) async throws -> Checklist
  public var createChecklist: @Sendable(_ checklist: Checklist) async throws -> Checklist

  public var deleteProject: @Sendable(_ checklistId: String) async throws -> Void
  public var deleteChecklist: @Sendable(_ checklistId: String, _ checkBoxId: String) async throws -> Void
  public var changeKeyword: @Sendable(_ checklistId: String, _ newKeyword: String) async throws -> Void
  public var changeItemKeyword: @Sendable(_ checklistId: String, _ checkBoxId: String,_ newKeyword: String) async throws -> Void
  public var complete: @Sendable(_ checklistId: String, _ id: String, _ completed: Bool) async throws -> Void
}

public extension DependencyValues {
  var checklistAPIClient: ChecklistAPIClient {
    get { self[ChecklistAPIClient.self] }
    set { self[ChecklistAPIClient.self] = newValue }
  }
}

extension ChecklistAPIClient: DependencyKey {
  public static var liveValue: ChecklistAPIClient = .init(
    getChecklists: {
      let api = ChecklistAPI.getChecklists
      let responseDTO: [ChecklistResponseDTO] = try await APIService<ChecklistAPI>().request(api: api)
      return responseDTO.map { $0.toEntity }
    },
    getChecklistItemList: { id in
      let api = ChecklistAPI.getChecklistItemList(id: id)
      let responseDTO: [ChecklistItemDTO] = try await APIService<ChecklistAPI>().request(api: api)
      return responseDTO.map { $0.toEntity }
    },
    getDraftChecklist: { id in
        let api = ChecklistAPI.getDraftCheckList(id: id)
        let responseDTO: [String] = try await APIService<ChecklistAPI>().request(api: api)
        return Checklist(
          id: UUID().uuidString,
          title: nil,
          checkBoxList: responseDTO.map { CheckBox(label: $0) }
        )
    },
    createChecklist: { checklist in
        let api = ChecklistAPI.createChecklist(checklist)
        let responseDTO: CreateChecklistResponseDTO  = try await APIService<ChecklistAPI>().request(api: api)
        var newCheckList = responseDTO.toEntity
        newCheckList.checkBoxList = checklist.checkBoxList
        return newCheckList
    },
    deleteProject: { checklistId in
      let api = ChecklistAPI.deleteProject(checklistId: checklistId)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    deleteChecklist: { checklistId, checkBox in
      let api = ChecklistAPI.deleteChecklist(checklistId: checklistId, checkBoxId: checkBox)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    changeKeyword: { checklistId, title in
      let api = ChecklistAPI.changeKeyword(checklistId: checklistId, newKeyword: title)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    changeItemKeyword: { checklistId, checkBoxId, title in
      let api = ChecklistAPI.changeItemKeyword(checklistId: checklistId, checkBoxId: checkBoxId, newKeyword: title)
      let responseDTO: EmptyResponseDTO = try await APIService<ChecklistAPI>().request(api: api)
    },
    complete: { checklistId, id, completed in
      let api = ChecklistAPI.complete(checklistId: checklistId, id: id, completed: completed ? 1 : 0)
      let responseDTO: String = try await APIService<ChecklistAPI>().request(api: api)
    }
  )
  
  public static var testValue: ChecklistAPIClient = Self()
}
