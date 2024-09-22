//
//  CheckListAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Moya

enum CheckListAPI {
  /// 목록 조회
  case getCheckLists(userID: String)
  /// 상세 조회
  case getCheckList(id: String)
  /// 체크리스트 프로젝트 삭제
  case deleteChecklist(checklistId: String)
  /// 체크리스트 다중 항목 삭제
  case deleteCheckList(checkListId: String, checkBoxList: [String])
  /// 체크리스트 프로젝트 제목 변경
  case changeKeyword(checkListId: String, newKeyword: String)
  /// 완료 상태 변경
  case complete(checklistId: String, id: String)
}

extension CheckListAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checkList
  }
  
  var method: Moya.Method {
    switch self {
    case .getCheckLists:
      return .get
    case .getCheckList:
      return .get
    case .deleteChecklist:
      return .delete
    case .deleteCheckList:
      return .delete
    case .changeKeyword:
      return .patch
    case .complete:
      return .patch
    }
  }
  
  var urlPath: String {
    switch self {
    case .getCheckLists:
      return ""
      
    case .getCheckList(let id):
      return "/\(id)/checkboxes"
      
    case .deleteChecklist(let checklistId):
      return "/\(checklistId)"
    
    case .deleteCheckList(let checkListId, _):
      return "/\(checkListId)/checkboxes"
    
    case .changeKeyword(let checkListId, _):
      return "/\(checkListId)"
    
    case .complete(let checklistId, let id):
      return "/\(checklistId)/checkboxes/\(id)/completed"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .getCheckLists(let userID):
      return [
        "userId": userID
      ]
      
    case .getCheckList:
      return nil
      
    case .deleteChecklist(let checklistId):
      return [
        "checklistId": checklistId
      ]
      
    case .deleteCheckList(_, let list):
      return [
        "checkboxIds": list
      ]
      
    case .changeKeyword(_, let keyword):
      return [
        "title": keyword
      ]
      
    case .complete(let checklistId, let id):
      return [
        "checklistId": checklistId,
        "id": id
      ]
    }
  }

  var error: [Int: NetworkError]? {
    return nil
  }
}
