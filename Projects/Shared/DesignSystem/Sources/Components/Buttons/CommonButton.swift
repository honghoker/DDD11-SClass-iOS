//
//  CommonButton.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/16/24.
//

import SwiftUI

public struct CommonButton: View {
    private let title: String
    private let style: CommonButtonStyle
    private let isActive: Bool
    private let action: () -> Void
    
  public init(title: String, style: CommonButtonStyle, isActive: Bool, action: @escaping () -> Void) {
    self.title = title
    self.style = style
    self.isActive = isActive
    self.action = action
  }
    
    public var body: some View {
        Button(action: {
            guard isActive else { return }
            action()
        }, label: {
            HStack(spacing: 4) {
                Text(title)
                .notoSans(.subhead_3)
                .foregroundStyle(style.textColor)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
        })
        .background(
          isActive ?
          style.activeBackgroundColor : style.disableBackgroundColor
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .if(style == .line && isActive) {
          $0
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                .stroke(.greyScale100, lineWidth: 1)
            }
        }
    }
}

public enum CommonButtonStyle {
  case line
  case `default`
  case contrast
  
  var textColor: Color {
    switch self {
    case .line:
      return Color.greyScale200
    case .`default`:
      return Color.white
    case .contrast:
      return Color.primary500
    }
  }
  
  var activeBackgroundColor: Color {
    switch self {
    case .line:
      return .white
    case .`default`:
      return .greyScale200
    case .contrast:
      return .white
    }
  }
  // TODO: line, contrast는 없는 상황
  var disableBackgroundColor: Color {
    switch self {
    case .line:
      return .white
    case .`default`:
      return .primary600
    case .contrast:
      return .white
    }
  }
}
