//
//  BaseChecklistCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 11/23/24.
//

import SwiftUI

enum ColorChecklistCellType {
  case `default`
  case detail
}

private extension ColorChecklistCellType {
  var defaultBackgroundColor: Color {
    switch self {
    case .default:
      return .primary050
    case .detail:
      return .greyScale0
    }
  }
  
  var selectedBackgroundColor: Color {
    switch self {
    case .default:
      return .primary100
    case .detail:
      return .greyScale050
    }
  }
}

struct BaseColorChecklistCellView: View {
  private let title: String
  private let isSelected: Bool
  private let type: ColorChecklistCellType
  private let onToggle: () -> Void
  
  public init(
    title: String,
    isSelected: Bool,
    type: ColorChecklistCellType,
    onToggle: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.onToggle = onToggle
    self.type = type
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
          onToggle: onToggle
        )
      }
    }
    .padding(.trailing, 15)
    .frame(maxWidth: .infinity)
    .frame(height: 48)
    .background(isSelected ? type.selectedBackgroundColor : type.defaultBackgroundColor)
    .clipShape(RoundedRectangle(cornerRadius: 4))
    .shadow(color: .greyScale950.opacity(0.05), radius: 5, x: 0, y: 4)
  }
}

private struct ColorCheckBoxButton: View {
  private let isSelected: Bool
  private let onToggle: () -> ()
  
  init(isSelected: Bool, onToggle: @escaping () -> ()) {
    self.isSelected = isSelected
    self.onToggle = onToggle
  }
  
  var body: some View {
    Button(action: {
      onToggle()
    }) {
      Rectangle()
        .if(isSelected) {
          $0
            .frame(width: 24, height: 24)
            .overlay(alignment: .center) {
              Image.check
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.primary900)
            }
        }
        .if(!isSelected) {
          $0
            .frame(width: 18, height: 18)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .overlay(
              RoundedRectangle(cornerRadius: 2)
                .stroke(.greyScale100, lineWidth: 1)
            )
            .padding(3)
        }
        .foregroundStyle(.clear)
    }
  }
}
