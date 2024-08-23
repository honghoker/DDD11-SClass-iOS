//
//  PromptExampleView.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/23/24.
//

import SwiftUI

public struct PromptExampleView: View {
  
  private let title: String
  private let content: String
  
  private let action: () -> ()
  
  @State private var isPressed: Bool = false
  
  public init(title: String, content: String, action: @escaping () -> ()) {
    self.title = title
    self.content = content
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .notoSans(.subhead_2)
          .foregroundStyle(isPressed ? Color.white : Color.greyScale950)
        Text(content)
          .notoSans(.caption)
          .foregroundStyle(isPressed ? Color.greyScale100 : Color.greyScale400)
      }
      .padding(.horizontal, 10)
      .padding(.vertical, 14)
      .background(isPressed ? Color.primary600 : Color.greyScale050)
      .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    .buttonStyle(
      PromptExampleButtonStyle(isPressed: $isPressed)
    )
    .frame(width: 192)
  }
}

private struct PromptExampleButtonStyle: ButtonStyle {
  @Binding private var isPressed: Bool
  
  fileprivate init(isPressed: Binding<Bool>) {
    self._isPressed = isPressed
  }
  
  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .onChange(of: configuration.isPressed) {
        isPressed = configuration.isPressed
      }
  }
}
