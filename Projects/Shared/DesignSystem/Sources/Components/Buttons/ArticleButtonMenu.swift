//
//  ArticleButtonMenu.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 3/14/25.
//

import SwiftUI

public struct ArticleButtonMenu: View {
  private let image: Image
  private let title: String
  private let defaultBackgroundColor: Color
  private let selectedBackgroundColor: Color
  private let defaultStrokeColor: Color
  private let selectedStrokeColor: Color
  private let isSelected: Bool
  private let onTap: () -> Void

  public init(
    image: Image,
    title: String,
    defaultBackgroundColor: Color = .greyScale0,
    selectedBackgroundColor: Color,
    defaultStrokeColor: Color = .init(hex: "F2F2F2"),
    selectedStrokeColor: Color,
    isSelected: Bool,
    onTap: @escaping () -> Void
  ) {
    self.image = image
    self.title = title
    self.defaultBackgroundColor = defaultBackgroundColor
    self.selectedBackgroundColor = selectedBackgroundColor
    self.defaultStrokeColor = defaultStrokeColor
    self.selectedStrokeColor = selectedStrokeColor
    self.isSelected = isSelected
    self.onTap = onTap
  }

  public var body: some View {
    Button(action: onTap) {
      VStack(alignment: .center, spacing: 6) {
        buttonImage
        buttonTitle
      }
    }
  }

  private var buttonImage: some View {
    image
      .resizable()
      .scaledToFit()
      .frame(width: 56, height: 56)
      .padding(7)
      .background(isSelected ? selectedBackgroundColor : defaultBackgroundColor)
      .clipShape(Circle())
      .overlay(
        Circle()
          .stroke(isSelected ? selectedStrokeColor : defaultStrokeColor, lineWidth: 2)
      )
  }

  private var buttonTitle: some View {
    Text(title)
      .notoSans(.body_1)
      .foregroundStyle(.greyScale950)
  }
}
