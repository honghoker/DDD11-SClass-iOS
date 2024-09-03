//
//  JobType.swift
//  DomainUser
//
//  Created by 홍은표 on 8/30/24.
//

import Foundation

public enum JobType: String, CaseIterable, Identifiable {
  case designer = "designer"
  case developer = "developer"
  case planner = "planner"
  
  public var id: Self {
    return self
  }
  
  public var name: String {
    switch self {
    case .designer:
      return "디자이너"
    case .developer:
      return "개발자"
    case .planner:
      return "기획자"
    }
  }
}
