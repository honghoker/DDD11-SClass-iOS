//
//  ChecklistCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

public struct DefaultChecklistCellView: View {
  @Binding private var isSelected: Bool
  private let title: String
  
  public init(
    isSelected: Binding<Bool>,
    title: String
  ) {
    self._isSelected = isSelected
    self.title = title
  }
  
  public var body: some View {
    HStack(spacing: .zero) {
      HStack(spacing: 12) {
        Rectangle()
          .frame(width: 4)
          .foregroundStyle(.primary500)
        
        HStack(spacing: 14) {
          CheckBoxButton(isSelected: $isSelected)
          
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
