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
          .foregroundStyle(isPressed ? .greyScale0 : .greyScale950)
        Text(content)
          .notoSans(.caption)
          .foregroundStyle(isPressed ? .greyScale100 : .greyScale400)
      }
      .padding(.horizontal, 10)
      .padding(.vertical, 14)
      .background(isPressed ? .primary600 : .greyScale050)
      .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    .buttonStyle(
      PressedButtonStyle(isPressed: $isPressed)
    )
    .frame(width: 192)
  }
}
