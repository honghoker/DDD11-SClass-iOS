//
//  PressedButtonStyle.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/25/24.
//

import SwiftUI

struct PressedButtonStyle: ButtonStyle {
  @Binding private var isPressed: Bool
  
  init(isPressed: Binding<Bool>) {
    self._isPressed = isPressed
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .onChange(of: configuration.isPressed) {
        isPressed = configuration.isPressed
      }
  }
}
