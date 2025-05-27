//
//  MyPageAPI.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/8/24.
//

import Foundation

import CoreDomain

import Moya

enum MyPageAPI {
  case fetchUser
}

extension MyPageAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .myPage
  }
  
  var urlPath: String {
    switch self {
    case .fetchUser:
      return "/member/me"
    }
  }
  
  var error: [Int : NetworkError]? {
    return nil
  }
  
  var parameters: [String : Any]? {
    switch self {
    case .fetchUser:
      return [:]
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchUser:
      return .get
    }
  }
}
