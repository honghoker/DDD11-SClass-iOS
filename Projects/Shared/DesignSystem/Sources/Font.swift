//
//  Font.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/3/24.
//

import SwiftUI

public extension Font {
  static func notoSans(_ type: FontToken) -> Font {
    type.font
  }
  
  static func notoSans(size fontSize: CGFloat, type: FontType) -> Font {
    return .custom("\(type.name)", size: fontSize)
  }
}

public extension Font {
  enum FontType {
    case bold
    case regular
    
    var name : String {
      switch self {
      case .bold:
        return "NotoSans-Bold"
      case .regular:
        return "NotoSans-Regular"
      }
    }
  }
  
  enum FontToken {
    
    // MARK: - title
    
    case display_05
    case display_04
    case display_03
    case display_02
    case display_01
    case headline
    case subhead_04
    case subhead_03
    case subhead_long_03
    case subhead_02
    case subhead_long_02
    case subhead_01
    case nav_title_active
    
    // MARK: - body
    
    case body_03
    case body_02
    case body_long_02
    case body_01
    case body_long_01
    case caption
    case nav_title_inactive
    
    var font: Font {
      switch self {
      case .display_05:
        return .notoSans(size: 40, type: .bold)
      case .display_04:
        return .notoSans(size: 36, type: .bold)
      case .display_03:
        return .notoSans(size: 32, type: .bold)
      case .display_02:
        return .notoSans(size: 28, type: .bold)
      case .display_01:
        return .notoSans(size: 24, type: .bold)
      case .headline:
        return .notoSans(size: 20, type: .bold)
      case .subhead_04:
        return .notoSans(size: 18, type: .bold)
      case .subhead_03:
        return .notoSans(size: 16, type: .bold)
      case .subhead_long_03:
        return .notoSans(size: 16, type: .bold)
      case .subhead_02:
        return .notoSans(size: 14, type: .bold)
      case .subhead_long_02:
        return .notoSans(size: 14, type: .bold)
      case .subhead_01:
        return .notoSans(size: 12, type: .bold)
      case .nav_title_active:
        return .notoSans(size: 10, type: .bold)
      case .body_03:
        return .notoSans(size: 18, type: .regular)
      case .body_02:
        return .notoSans(size: 16, type: .regular)
      case .body_long_02:
        return .notoSans(size: 16, type: .regular)
      case .body_01:
        return .notoSans(size: 14, type: .regular)
      case .body_long_01:
        return .notoSans(size: 14, type: .regular)
      case .caption:
        return .notoSans(size: 12, type: .regular)
      case .nav_title_inactive:
        return .notoSans(size: 10, type: .regular)
      }
    }
    
    var lineHeight: CGFloat {
      switch self {
      case .display_05:
        return 52
      case .display_04:
        return 46
      case .display_03:
        return 42
      case .display_02:
        return 38
      case .display_01:
        return 34
      case .headline:
        return 28
      case .subhead_04:
        return 24
      case .subhead_03:
        return 22
      case .subhead_long_03:
        return 28
      case .subhead_02:
        return 20
      case .subhead_long_02:
        return 24
      case .subhead_01:
        return 18
      case .nav_title_active:
        return 16
      case .body_03:
        return 24
      case .body_02:
        return 24
      case .body_long_02:
        return 28
      case .body_01:
        return 20
      case .body_long_01:
        return 24
      case .caption:
        return 18
      case .nav_title_inactive:
        return 16
      }
    }
  }
}
