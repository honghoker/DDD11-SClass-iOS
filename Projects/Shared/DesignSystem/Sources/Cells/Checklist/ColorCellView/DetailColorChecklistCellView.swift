//
//  DetailColorChecklistCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 11/23/24.
//

import SwiftUI

public struct DetailColorChecklistCellView: View {
  private let title: String
  private let isSelected: Bool
  private let onToggle: () -> Void
  
  public init(
    title: String,
    isSelected: Bool,
    onToggle: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.onToggle = onToggle
  }
  
  public var body: some View {
    BaseColorChecklistCellView(
      title: title,
      isSelected: isSelected,
      type: .detail,
      onToggle: onToggle
    )
  }
}
