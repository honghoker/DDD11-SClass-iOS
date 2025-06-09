//
//  LoginAPI.swift
//  CoreNetwork
//
//  Created by 현수빈 on 5/14/25.
//


import Foundation

import CoreDomain

import Moya

enum LoginAPI {
  case login(_ socialLoginInfo: SocialLoginInfo)
  case refreshToken(_ refreshToken: String)
}

extension LoginAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .login
  }
  
  var urlPath: String {
    switch self {
    case .login:
      return "/login"
    case .refreshToken(_):
      return "/reissue"
    }
  }
  
  var error: [Int : NetworkError]? {
    return nil
  }
  
  var parameters: [String : Any]? {
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
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login(_):
      return .post
    case .refreshToken(_):
      return .post
    }
  }
}
