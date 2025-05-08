//
//  ArticleCategoryResponse.swift
//  CoreNetwork
//
//  Created by eunpyo on 4/30/25.
//

import Foundation

public enum ArticleCategoryResponse: String, Decodable {
  case all = "전체"
  case development = "개발"
  case plan = "기획"
  case design = "디자인"
}

public enum ArticleSubcategoryResponse: String, Decodable {
  case generalDevelopment = "일반 개발"
  case frontend = "프론트엔드"
  case backend = "백엔드"

  case generalPlan = "일반 기획"
  case service = "서비스 기획"
  case productManagement = "프로덕트 관리"

  case generalDesign = "일반디자인"
  case ux = "UX"
  case uiux = "UI/UX"

  case unknown

  public init(from decoder: Decoder) throws {
    let raw = try decoder.singleValueContainer().decode(String.self)
    self = ArticleSubcategoryResponse(rawValue: raw) ?? .unknown
  }
}
