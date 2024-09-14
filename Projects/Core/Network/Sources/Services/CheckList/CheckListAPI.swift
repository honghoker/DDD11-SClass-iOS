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
  case getCheckList(id: String)
  case deleteCheckList(checkListId: String, checkBoxList: [String])
  case changeKeyword(checkListId: String, newKeyword: String)
}

extension CheckListAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checkList
  }
  
  var method: Moya.Method {
    switch self {
    case .getCheckList(_):
      return .get
    case .deleteCheckList(checkListId: _, checkBoxList: _):
      return .delete
    case .changeKeyword(checkListId: _, newKeyword: _):
      return .patch
    }
  }
  
  var urlPath: String {
    switch self {
    case .getCheckList(let id):
      return "\(id)/checkboxes"
    case .deleteCheckList(checkListId: let checkListId, checkBoxList: _):
      return "\(checkListId)/checkboxes"
    case .changeKeyword(checkListId: let checkListId, newKeyword: _):
      return "\(checkListId)"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .deleteCheckList(checkListId:  _, checkBoxList: let list):
      return [
        "checkboxIds": list
      ]
    case .changeKeyword(checkListId: _, newKeyword: let keyword):
      return [
        "title": keyword
      ]
    default:
      return .none
    }
  }

  
  var error: [Int: NetworkError]? {
    return nil
  }
}
