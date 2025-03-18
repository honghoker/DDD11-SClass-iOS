//
//  ArticleCategory+UI.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem

extension ArticleCategory {
  var image: Image {
    switch self {
    case .all:
      return .articleAll
    case .development:
      return .articleDevelopment
    case .plan:
      return .articlePlan
    case .design:
      return .articleDesign
    }
  }

  var title: String {
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

  var selectedBackgroundColor: Color {
    switch self {
    case .all:
      return .init(hex: "EDF8FF")
    case .development:
      return .init(hex: "EAEEF4")
    case .plan:
      return .init(hex: "F0E9FF")
    case .design:
      return .init(hex: "EAFFEA")
    }
  }

  var selectedStrokeColor: Color {
    switch self {
    case .all:
      return .init(hex: "D0EDFF")
    case .development:
      return .init(hex: "CBD2E2")
    case .plan:
      return .init(hex: "E2D3FB")
    case .design:
      return .init(hex: "CAF9C1")
    }
  }
}
