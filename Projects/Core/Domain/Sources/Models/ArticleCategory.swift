//
//  ArticleCategory.swift
//  CoreDomain
//
//  Created by eunpyo on 3/15/25.
//

import Foundation

public enum ArticleCategory: CaseIterable {
  case all
  case development
  case plan
  case design

  public init(id: Int?) {
    self = Self.allCases.first(where: { $0.id == id }) ?? .all
  }

  public var id: Int? {
    switch self {
    case .all:
      return nil
    case .development:
      return 1
    case .plan:
      return 2
    case .design:
      return 3
    }
  }

  public var title: String {
    switch self {
    case .all:
      return "전체"
    case .development:
      return "개발"
    case .plan:
      return "기획"
    case .design:
      return "디자인"
    }
  }

  public var subcategories: [ArticleSubcategory]? {
    switch self {
    case .all:
      return nil
    case .development:
      return [.all, .generalDevelopment, .frontend, .backend]
    case .plan:
      return [.all, .generalPlan, .service, .productManagement]
    case .design:
      return [.all, .generalDesign, .ux, .uiUX]
    }
  }
}

public enum ArticleSubcategory: CaseIterable {
  case all
  case generalDevelopment
  case frontend
  case backend

  case generalPlan
  case service
  case productManagement

  case generalDesign
  case ux
  case uiUX

  init(id: Int?) {
    self = Self.allCases.first(where: { $0.id == id }) ?? .all
  }

  public var id: Int? {
    switch self {
    case .all:
      return nil
    case .generalDevelopment:
      return 4
    case .frontend:
      return 5
    case .backend:
      return 6
    case .generalPlan:
      return 7
    case .service:
      return 8
    case .productManagement:
      return 9
    case .generalDesign:
      return 10
    case .ux:
      return 11
    case .uiUX:
      return 12
    }
  }

  public var title: String {
    switch self {
    case .all:
      return "전체 선택"
    case .generalDevelopment:
      return "일반 개발"
    case .frontend:
      return "프론트엔드"
    case .backend:
      return "백엔드"
    case .generalPlan:
      return "일반 기획"
    case .service:
      return "서비스 기획"
    case .productManagement:
      return "프로덕트 관리"
    case .generalDesign:
      return "일반디자인"
    case .ux:
      return "UX"
    case .uiUX:
      return "UI/UX"
    }
  }
}
