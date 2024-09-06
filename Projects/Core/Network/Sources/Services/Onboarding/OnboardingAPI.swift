//
//  OnboardingAPI.swift
//  CoreNetwork
//
//  Created by 홍은표 on 8/30/24.
//

import Foundation

import CoreDomain

import Moya

enum OnboardingAPI {
  case signUp(_ requestDTO: SignUpRequestDTO)
}

extension OnboardingAPI: BaseAPI {
  var domain: OnboardingKitDomain {
    return .onboarding
  }
  
  var method: Moya.Method {
    switch self {
    case .signUp:
      return .post
    }
  }
  
  var urlPath: String {
    switch self {
    case .signUp:
      return ""
    }
  }
  
  var parameters: [String: Any]? {
    return nil
  }
  
  var task: Task {
    switch self {
    case .signUp(let requestDTO):
      return .requestJSONEncodable(requestDTO)
    }
  }
  
  var error: [Int: NetworkError]? {
    return nil
  }
}
