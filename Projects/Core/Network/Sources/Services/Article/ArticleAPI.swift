//
//  ArticleAPI.swift
//  CoreNetwork
//
//  Created by eunpyo on 4/4/25.
//

import Foundation

import Moya

enum ArticleAPI {
  case fetchArticles
}

extension ArticleAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .article
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
    case .fetchArticles:
      return nil
    }
  }

  var method: Moya.Method {
    switch self {
    case .fetchArticles:
      return .get
    }
  }
}
