//
//  ColoredText.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/20/24.
//

import SwiftUI

public struct ColoredText: View {
  @Binding var isPressed: Bool
  
  private let fullText: String
  private let highLightText: String
  
  private let defaultColor: Color
  private let highLightColor: Color
  private let pressedColor: Color
  
  public init(
    isPressed: Binding<Bool> = .constant(false),
    fullText: String,
    highLightText: String,
    defaultColor: Color = .greyScale950,
    highLightColor: Color = .primary600,
    pressedColor: Color = .white
  ) {
    self._isPressed = isPressed
    self.fullText = fullText
    self.highLightText = highLightText
    self.defaultColor = defaultColor
    self.highLightColor = highLightColor
    self.pressedColor = pressedColor
  }
  
  public var body: some View {
    if let coloredRange = fullText.range(of: highLightText) {
      let beforeRange = fullText[..<coloredRange.lowerBound]
      let coloredText = fullText[coloredRange]
      let afterRange = fullText[coloredRange.upperBound...]
      
      return Text(beforeRange)
        .foregroundStyle(isPressed ? pressedColor : defaultColor)
      + Text(coloredText)
        .foregroundStyle(isPressed ? pressedColor : highLightColor)
      + Text(afterRange)
        .foregroundStyle(isPressed ? pressedColor : defaultColor)
    } else {
      return Text(fullText)
        .foregroundStyle(isPressed ? pressedColor : defaultColor)
    }
  }
}
