//
//  ColorChecklistCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 9/22/24.
//

import SwiftUI

public struct ColorChecklistCellView: View {
  private let title: String
  private let isSelected: Bool
  private let onTap: () -> Void
  
  public init(
    title: String,
    isSelected: Bool,
    onTap: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.onTap = onTap
  }
  
  public var body: some View {
    HStack(spacing: .zero) {
      HStack(spacing: 12) {
        Rectangle()
          .frame(width: 4)
          .foregroundStyle(!isSelected ? .primary500 : .clear)
        
        Text(title)
          .notoSans(.body_long_1)
          .foregroundStyle(.greyScale600)
        
        Spacer()
        
        ColorCheckBoxButton(
          isSelected: isSelected,
          action: onTap
        )
      }
    }
    .padding(.trailing, 15)
    .frame(maxWidth: .infinity)
    .frame(height: 48)
    .background(isSelected ? .primary100 : .primary050)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 4)
  }
}
