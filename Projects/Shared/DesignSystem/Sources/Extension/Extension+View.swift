//
//  Extension+View.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/16/24.
//

import SwiftUI

public extension View {
  @ViewBuilder
  func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
    if condition {
      content(self)
    } else {
      self
    }
  }
}
