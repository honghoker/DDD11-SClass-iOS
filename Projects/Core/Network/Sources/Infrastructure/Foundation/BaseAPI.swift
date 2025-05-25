//
//  BaseAPI.swift
//  OnboardingKit.
//
//  Created by 현수빈 on 2/23/24.
//

import Foundation

import Moya

enum OnboardingKitDomain {
  case onboarding
  case home
  case myPage
  case chat
  case checklist
  case article
  case login
}

extension OnboardingKitDomain {
  // TODO: - API 명세 나온 후 수정 필요
  var url: String {
    switch self {
    case .onboarding:
      return ""
    case .home:
      return "/main"
    case .myPage:
      return ""
    case .chat:
      return "/v1/prompt"
    case .checklist:
      return "/checklists"
    case .article:
      return ""
    case .login:
      return "/oauth"
    }
  }
}

protocol BaseAPI: TargetType {
  var domain: OnboardingKitDomain { get }
  var urlPath: String { get }
  var error: [Int: NetworkError]? { get }
  var parameters: [String: Any]? { get }
}

extension BaseAPI {
  
  var baseURL: URL {
    return URL(string: NetworkEnvironment.baseURL)!
  }
  
  var path: String {
    return domain.url + urlPath
  }
  
  var validationType: ValidationType {
    return .successCodes
  }
  
  var headers: [String: String]? {
    switch self {
    default:
      return NetworkEnvironment.HTTPHeaderField.default
    }
  }
  
  var task: Task {
    if let parameters = parameters {
      if method == .get {
          return .requestParameters(
            parameters: parameters,
            encoding: URLEncoding.queryString
          )
      } else {
        return .requestParameters(
          parameters: parameters,
          encoding: JSONEncoding.default
        )
      }
    }
    return .requestPlain
  }
}
