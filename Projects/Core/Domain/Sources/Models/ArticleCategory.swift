//
//  ArticleCategory.swift
//  CoreDomain
//
//  Created by eunpyo on 3/15/25.
//

import Foundation

public enum ArticleCategory: String, CaseIterable {
  case all = "전체"
  case development = "개발"
  case plan = "기획"
  case design = "디자인"

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

public enum ArticleSubcategory: String, CaseIterable {
  case all = "전체 선택"
  case generalDevelopment = "일반 개발"
  case frontend = "프론트엔드"
  case backend = "백엔드"

  case generalPlan = "일반 기획"
  case service = "서비스 기획"
  case productManagement = "프로덕트 관리"

  case generalDesign = "일반디자인"
  case ux = "UX"
  case uiUX = "UI/UX"
}
