//
//  TabItem.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/27/24.
//

import SwiftUI

public enum MainTabItem: Hashable {
  case home
  case history
  case chat
  case article
  case myPage
  
  public var title: String {
    switch self {
    case .home:
      return "홈"
    case .history:
      return "기록"
    case .chat:
      return ""
    case .article:
      return "아티클"
    case .myPage:
      return "마이페이지"
    }
  }
  
  public var image: Image {
    switch self {
    case .home:
      return Image.home
    case .history:
      return Image.history
    case .chat:
      return Image.plus
    case .article:
      return Image.article
    case .myPage:
      return Image.myPage
    }
  }
}
