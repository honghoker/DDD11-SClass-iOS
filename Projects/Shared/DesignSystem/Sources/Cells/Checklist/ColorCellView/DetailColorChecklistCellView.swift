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
  private let onDelete: () -> Void
  
  public init(
    title: String,
    isSelected: Bool,
    onToggle: @escaping () -> Void,
    onDelete: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.onToggle = onToggle
    self.onDelete = onDelete
  }
  
  public var body: some View {
    BaseColorChecklistCellView(
      title: title,
      isSelected: isSelected,
      type: .detail,
      onToggle: onToggle
    )
    .listRowBackground(Color.clear)
    .listRowSeparator(.hidden)
    .listRowInsets(.init(top: 0, leading: 12, bottom: 0, trailing: 12))
    .swipeActions(edge: .trailing) {
      Button {
        onDelete()
      } label: {
        Image.trash
      }
      .tint(.red)
    }
  }
}
