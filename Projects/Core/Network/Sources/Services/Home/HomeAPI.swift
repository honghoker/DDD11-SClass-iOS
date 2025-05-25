//
//  HomeAPI.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import Moya

enum HomeAPI {
  case fetchArticles(_ accessToken: String)
}

extension HomeAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .home
  }
  
  var urlPath: String {
    switch self {
    case .fetchArticles:
      return "/articles"
    }
  }
  
  
  var error: [Int : NetworkError]? {
    return nil
  }
  
  var parameters: [String : Any]? {
    switch self {
    case .fetchArticles(_):
      return [:]
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchArticles:
      return .get
    }
  }
}
