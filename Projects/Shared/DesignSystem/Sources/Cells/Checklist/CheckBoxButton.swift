//
//  CheckBoxButton.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

struct CheckBoxButton: View {
  @Binding private var isSelected: Bool
  private let action: () -> ()
  
  init(isSelected: Binding<Bool>, action: @escaping () -> ()) {
    self._isSelected = isSelected
    self.action = action
  }
  
  var body: some View {
    Button(action: {
      isSelected.toggle()
      action()
    }) {
      Image.check
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .frame(width: 11.85, height: 7.84)
        .foregroundStyle(isSelected ? .white : .greyScale100)
        .frame(width: 20, height: 20)
        .background(isSelected ? .primary500 : .white)
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .overlay(
          RoundedRectangle(cornerRadius: 2)
            .stroke(isSelected ? .clear : .greyScale100, lineWidth: 1)
        )
    }
  }
}
