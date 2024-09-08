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
}

extension CheckListAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .checkList
  }
  
  var method: Moya.Method {
    switch self {
    case .getCheckList(_):
      return .get
    }
  }
  
  var urlPath: String {
    switch self {
    case .getCheckList(let id):
      return "\(id)/checkboxes"
      
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    default:
      return .none
    }
  }

  
  var error: [Int: NetworkError]? {
    return nil
  }
}
