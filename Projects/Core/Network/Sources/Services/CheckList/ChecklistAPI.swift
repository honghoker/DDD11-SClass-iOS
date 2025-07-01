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
  case getChecklists
  /// 상세 조회
  case getChecklistItemList(id: String)
    
  case getDraftCheckList(id: String)
  /// 체크리스트 생성
  case createChecklist(Checklist)
  /// 체크리스트 프로젝트 삭제
  case deleteProject(checklistId: String)
  /// 체크리스트 다중 항목 삭제
  case deleteChecklist(checklistId: String, checkBoxId: String)
  /// 체크리스트 프로젝트 제목 변경
  case changeKeyword(checklistId: String, newKeyword: String)
  /// 체크리스트 체크박스 제목 변경
  case changeItemKeyword(checklistId: String, checkBoxId: String, newKeyword: String)
  /// 완료 상태 변경
  case complete(checklistId: String, id: String, completed: Int)
}

extension ChecklistAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checklist
  }
  
  var method: Moya.Method {
    switch self {
    case .getChecklists:
      return .get
    case .getChecklistItemList:
      return .get
    case .getDraftCheckList:
      return .get
    case .createChecklist:
        return .post
    case .deleteProject:
      return .delete
    case .deleteChecklist:
      return .delete
    case .changeKeyword:
      return .put
    case .changeItemKeyword:
      return .put
    case .complete:
      return .patch
    }
  }
  
  var urlPath: String {
    switch self {
    case .getChecklists:
      return ""
      
    case .getChecklistItemList(let id):
      return "/\(id)/items"
      
    case .getDraftCheckList(id: let id):
        return "/drafts/\(id)"
        
    case .createChecklist:
        return "/compose"
        
    case .deleteProject(let checklistId):
      return "/\(checklistId)"
    
    case .deleteChecklist(let checklistId, let checkBoxId):
      return "/\(checklistId)/items/\(checkBoxId)"
    
    case .changeKeyword(let checklistId, _):
      return "/\(checklistId)/title"
      
    case .changeItemKeyword(let checklistId, let checkBoxId, _):
      return "/\(checklistId)/items/\(checkBoxId)"
    
    case .complete(let checklistId, let id, _):
      return "/\(checklistId)/items/\(id)/complete"
    }
  }

  
  var parameters: [String: Any]? {
    switch self {
    case .getChecklists:
      return nil
      
    case .getChecklistItemList:
      return nil
        
    case .getDraftCheckList:
      return nil
        
    case .createChecklist(let checklist):
        return [
            "title": checklist.title ?? "",
            "items": checklist.checkBoxList.map { $0.label }
        ]
      
    case .deleteProject(let checklistId):
      return [
        "checklistId": checklistId
      ]
      
    case .deleteChecklist:
      return nil

    case .changeKeyword(_, let keyword):
      return [
        "title": keyword
      ]
      
    case .changeItemKeyword(checklistId: _, checkBoxId: _, newKeyword: let keyword):
      return [
        "content": keyword
      ]
  
    case .complete:
      return [:]
    }
  }

  var error: [Int: NetworkError]? {
    return nil
  }
}
