//
//  Chip.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/20/24.
//

import SwiftUI

public struct Chip: View {
  
  private let title: String
  private let style: Style
  
  public init(
    title: String,
    style: Style
  ) {
    self.title = title
    self.style = style
  }
  
  public var body: some View {
    Text(title)
      .notoSans(.body_2)
      .foregroundStyle(style.color)
      .padding(.horizontal, 20)
      .padding(.vertical, 8)
      .overlay {
        RoundedRectangle(cornerRadius: 20)
          .stroke(style.borderColor, lineWidth: 1)
      }
  }
  
  public enum Style {
    case `default`
    case blue
    
    var color: Color {
      switch self {
      case .default:
        return .greyScale700
      case .blue:
        return .primary500
      }
    }
    
    var borderColor: Color {
      switch self {
      case .default:
        return .greyScale300
      case .blue:
        return .primary500
      }
    }
  }
}
