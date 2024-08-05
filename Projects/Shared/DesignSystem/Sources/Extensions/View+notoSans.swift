//
//  View+OKFont.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/6/24.
//

import Foundation
import SwiftUI

public extension View {
  func notoSans(_ token: Font.Token) -> some View {
    self.modifier(FontAndLineHeightModifier(typography: token.typography))
  }
}

private struct FontAndLineHeightModifier: ViewModifier {
  private let typography: Typographyable
  
  fileprivate init(typography: Typographyable) {
    self.typography = typography
  }
  
  fileprivate func body(content: Content) -> some View {
    content
      .font(Font(typography.font))
      .lineSpacing(typography.lineHeight - typography.font.lineHeight)
      .padding(.vertical, (typography.lineHeight - typography.font.lineHeight) / 2)
  }
}
