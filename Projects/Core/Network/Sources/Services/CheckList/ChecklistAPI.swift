//
//  ChecklistAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Moya

enum ChecklistAPI {
  /// 목록 조회
  case getChecklists(userID: String)
  /// 상세 조회
  case getChecklist(id: String)
  /// 체크리스트 프로젝트 삭제
  case deleteProject(checklistId: String)
  /// 체크리스트 다중 항목 삭제
  case deleteChecklist(checkListId: String, checkBoxList: [String])
  /// 체크리스트 프로젝트 제목 변경
  case changeKeyword(checkListId: String, newKeyword: String)
  /// 완료 상태 변경
  case complete(checklistId: String, id: String, completed: Int)
}

extension ChecklistAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checkList
  }
  
  var method: Moya.Method {
    switch self {
    case .getChecklists:
      return .get
    case .getChecklist:
      return .get
    case .deleteProject:
      return .delete
    case .deleteChecklist:
      return .delete
    case .changeKeyword:
      return .patch
    case .complete:
      return .patch
    }
  }
  
  var urlPath: String {
    switch self {
    case .getChecklists:
      return ""
      
    case .getChecklist(let id):
      return "/\(id)/checkboxes"
      
    case .deleteProject(let checklistId):
      return "/\(checklistId)"
    
    case .deleteChecklist(let checkListId, _):
      return "/\(checkListId)/checkboxes"
    
    case .changeKeyword(let checkListId, _):
      return "/\(checkListId)"
    
    case .complete(let checklistId, let id, _):
      return "/\(checklistId)/checkboxes/\(id)/completed"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .getChecklists(let userID):
      return [
        "userId": userID
      ]
      
    case .getChecklist:
      return nil
      
    case .deleteProject(let checklistId):
      return [
        "checklistId": checklistId
      ]
      
    case .deleteChecklist(_, let list):
      return [
        "checkboxIds": list
      ]
      
    case .changeKeyword(_, let keyword):
      return [
        "title": keyword
      ]
      
    case .complete(let checklistId, let id, let completed):
      return [
        "checklistId": checklistId,
        "id": id,
        "completed": completed
      ]
    }
  }

  var error: [Int: NetworkError]? {
    return nil
  }
}
