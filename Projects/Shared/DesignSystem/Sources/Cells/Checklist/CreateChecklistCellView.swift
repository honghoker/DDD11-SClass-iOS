//
//  ChecklistCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

public struct CreateChecklistCellView: View {
  @Binding private var isSelected: Bool
  private let title: String
  private let onToggle: () -> ()
  
  public init(
    isSelected: Binding<Bool>,
    title: String,
    onToggle: @escaping () -> ()
  ) {
    self._isSelected = isSelected
    self.title = title
    self.onToggle = onToggle
  }
  
  public var body: some View {
    HStack(spacing: .zero) {
      HStack(spacing: 12) {
        Rectangle()
          .frame(width: 4)
          .foregroundStyle(.primary500)
        
        HStack(spacing: 14) {
          CheckBoxButton(
            isSelected: $isSelected,
            onToggle: onToggle
          )
          
          Text(title)
            .notoSans(.subhead_3)
            .foregroundStyle(.primary950)
        }
      }
      
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .frame(height: 78)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 4)
  }
}

private struct CheckBoxButton: View {
  @Binding private var isSelected: Bool
  private let onToggle: () -> ()
  
  fileprivate init(isSelected: Binding<Bool>, onToggle: @escaping () -> ()) {
    self._isSelected = isSelected
    self.onToggle = onToggle
  }
  
  fileprivate var body: some View {
    Button(action: {
      isSelected.toggle()
      onToggle()
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
