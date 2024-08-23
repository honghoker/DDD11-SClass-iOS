//
//  ChatInputView.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/23/24.
//

import SwiftUI

public struct ChatInputView<T: Hashable>: View {
  
  private let isFocused: FocusState<T>.Binding
  private let focusValue: T
  
  @Binding private var text: String
  private let action: () -> ()
  
  
  public init(
    text: Binding<String>,
    action: @escaping () -> Void,
    isFocused: FocusState<T>.Binding,
    focusValue: T = true
  ) {
    self._text = text
    self.action = action
    self.isFocused = isFocused
    self.focusValue = focusValue
  }
  
  public var body: some View {
    HStack(spacing: 12) {
      
      TextField("도움이 필요한 것을 물어보세요", text: $text)
        .notoSans(.body_1)
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
          isFocused.wrappedValue == focusValue ? Color.white : .greyScale050
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
          RoundedRectangle(cornerRadius: 10)
            .stroke(
              .greyScale050,
              lineWidth: 1
            )
        }
      
      Button(action: {
        action()
      }) {
        if text.isEmpty {
          Image.sendDeactive
        } else {
          Image.sendActive
        }
      }
      .frame(width: 24)
      .disabled(text.isEmpty)
    }
  }
}
