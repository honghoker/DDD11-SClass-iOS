//
//  OnboardingAPI.swift
//  CoreNetwork
//
//  Created by 홍은표 on 8/30/24.
//

import Foundation

import Moya

enum OnboardingAPI {
  case signUp(userID: String, nickname: String, job: String, workExperience: Int)
}

extension OnboardingAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .onboarding
  }
  
  var urlPath: String {
    switch self {
    case .signUp:
      return ""
    }
  }
  
  var error: [Int: NetworkError]? {
    return nil
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .signUp(let userID, let nickname, let job, let workExperience):
      return [
        "userId": userID,
        "nickname": nickname,
        "job": job,
        "workExperience": workExperience
      ]
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .signUp:
      return .post
    }
  }
}
