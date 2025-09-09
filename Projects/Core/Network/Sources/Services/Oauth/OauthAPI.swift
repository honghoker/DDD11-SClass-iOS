//
//  OauthAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 5/14/25.
//


import Foundation

import CoreDomain

import Moya

enum OauthAPI {
  case login(_ socialLoginInfo: SocialLoginInfo)
  case refreshToken(_ refreshToken: String)
  case logout
  case withdraw
}

extension OauthAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .login
  }
  
  var urlPath: String {
    switch self {
    case .login:
      return "/login"
    case .refreshToken:
      return "/reissue"
    case .logout:
      return "/logout"
    case .withdraw:
      return "/withdraw"
    }
  }
  
  var error: [Int: NetworkError]? {
    return nil
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .login(let userInfo):
      return [
        "socialType": userInfo.provider.rawValue,
        "token": userInfo.idToken
      ]
    case .refreshToken(let refreshToken):
      return [
        "refreshToken": refreshToken
      ]
    case .logout:
      return nil
    case .withdraw:
      return nil
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login:
      return .post
    case .refreshToken:
      return .post
    case .logout:
      return .post
    case .withdraw:
      return .delete
    }
  }
}
