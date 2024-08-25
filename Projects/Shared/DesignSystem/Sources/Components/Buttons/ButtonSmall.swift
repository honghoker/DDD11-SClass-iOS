//
//  ButtonSmall.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/20/24.
//

import SwiftUI

public struct ButtonSmall: View {
  
  @State private var isPressed: Bool = false
  
  private let title: String
  private let highLightTitle: String
  private let action: () -> Void
  
  public init(
    title: String,
    highLightTitle: String = "",
    action: @escaping () -> Void
  ) {
    self.title = title
    self.highLightTitle = highLightTitle
    self.action = action
  }
  
  public var body: some View {
    Button(action: {
      action()
    },
           label: {
      HStack(spacing: 4) {
        Image.rotateLeft
          .resizable()
          .scaledToFit()
          .frame(width: 20)
          .foregroundStyle(isPressed ? .white : .greyScale950)
        
        
        ColoredText(
          isPressed: $isPressed,
          fullText: title,
          highLightText: highLightTitle
        )
        .notoSans(.body_1)
        
      }
      .padding(.horizontal, 16)
      .frame(maxWidth: .infinity)
      .frame(height: 48)
    })
    .background(isPressed ? .primary600 : .white)
    .clipShape(RoundedRectangle(cornerRadius: 10))
    .overlay {
      RoundedRectangle(cornerRadius: 10)
        .stroke(.greyScale100, lineWidth: 1)
    }
    .buttonStyle(PressedButtonStyle(isPressed: $isPressed))
  }
}
