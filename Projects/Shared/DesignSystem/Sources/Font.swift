//
//  Font.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/3/24.
//

import SwiftUI

protocol Typographyable {
  var font: UIFont { get }
  var lineHeight: CGFloat { get }
}

public extension Font {
  struct NotoSans: Typographyable {
    let size: CGFloat
    let lineHeight: CGFloat
    let weight: FontWeight
    
    var font: UIFont {
      UIFont(name: weight.name, size: size)!
    }
    
    enum FontWeight {
      case bold
      case regular
      
      var name: String {
        switch self {
        case .bold:
          return "NotoSans-Bold"
        case .regular:
          return "NotoSans-Regular"
        }
      }
    }
  }
  
  enum Token {
    case display_5
    case display_4
    case display_3
    case display_2
    case display_1
    case headline
    case subhead_4
    case subhead_3
    case subhead_long_3
    case subhead_2
    case subhead_long_2
    case subhead_1
    case nav_title_active
    case body_3
    case body_2
    case body_long_2
    case body_1
    case body_long_1
    case caption
    case nav_title_inactive
    
    var typography: Typographyable {
      switch self {
      case .display_5:
        return NotoSans(size: 40, lineHeight: 52, weight: .bold)
      case .display_4:
        return NotoSans(size: 36, lineHeight: 46, weight: .bold)
      case .display_3:
        return NotoSans(size: 32, lineHeight: 42, weight: .bold)
      case .display_2:
        return NotoSans(size: 28, lineHeight: 38, weight: .bold)
      case .display_1:
        return NotoSans(size: 24, lineHeight: 34, weight: .bold)
      case .headline:
        return NotoSans(size: 20, lineHeight: 28, weight: .bold)
      case .subhead_4:
        return NotoSans(size: 18, lineHeight: 24, weight: .bold)
      case .subhead_3:
        return NotoSans(size: 16, lineHeight: 22, weight: .bold)
      case .subhead_long_3:
        return NotoSans(size: 16, lineHeight: 28, weight: .bold)
      case .subhead_2:
        return NotoSans(size: 14, lineHeight: 20, weight: .bold)
      case .subhead_long_2:
        return NotoSans(size: 14, lineHeight: 24, weight: .bold)
      case .subhead_1:
        return NotoSans(size: 12, lineHeight: 18, weight: .bold)
      case .nav_title_active:
        return NotoSans(size: 10, lineHeight: 16, weight: .bold)
      case .body_3:
        return NotoSans(size: 18, lineHeight: 24, weight: .regular)
      case .body_2:
        return NotoSans(size: 16, lineHeight: 24, weight: .regular)
      case .body_long_2:
        return NotoSans(size: 16, lineHeight: 28, weight: .regular)
      case .body_1:
        return NotoSans(size: 14, lineHeight: 20, weight: .regular)
      case .body_long_1:
        return NotoSans(size: 14, lineHeight: 24, weight: .regular)
      case .caption:
        return NotoSans(size: 12, lineHeight: 18, weight: .regular)
      case .nav_title_inactive:
        return NotoSans(size: 10, lineHeight: 16, weight: .regular)
      }
    }
  }
}
