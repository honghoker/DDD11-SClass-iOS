//
//  ArticleSelectSubcategoryBottomSheetView.swift
//  FeatureArticle
//
//  Created by eunpyo on 4/30/25.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem

struct ArticleSelectSubcategoryBottomSheetView: View {
  private let category: ArticleCategory
  private let selectedSubcategory: ArticleSubcategory?
  private let onSelect: (ArticleSubcategory) -> Void
  private let onClose: () -> Void

  init(
    category: ArticleCategory,
    selectedSubcategory: ArticleSubcategory?,
    onSelect: @escaping (ArticleSubcategory) -> Void,
    onClose: @escaping () -> Void
  ) {
    self.category = category
    self.selectedSubcategory = selectedSubcategory
    self.onSelect = onSelect
    self.onClose = onClose
  }

  private let columns = [
    GridItem(.flexible(), spacing: 63),
    GridItem(.flexible())
  ]

  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      topNavigation

      HStack(spacing: 2) {
        category.image
          .resizable()
          .scaledToFit()
          .frame(width: 28, height: 28)

        Text(category.title)
          .notoSans(.headline)
          .foregroundStyle(.greyScale950)
      }
      .padding(.top, 20)
      .padding(.horizontal, 26)

      if let subcategories = category.subcategories {
        items(subcategories: subcategories)
      }

      Spacer()
    }
    .onDisappear(perform: onClose)
  }

  private var topNavigation: some View {
    HStack {
      Spacer()

      Button(action: onClose) {
        Image.closeCross
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      }
      .buttonStyle(.plain)
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .frame(height: 48)
    .overlay(alignment: .center) {
      Text("세부 직무")
        .notoSans(.headline)
        .foregroundStyle(.greyScale950)
    }
    .padding(.top, 19)
  }

  private func items(subcategories: [ArticleSubcategory]) -> some View {
    ScrollView {
      LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
        ForEach(subcategories, id: \.self) { item in
          Button(action: {
            onSelect(item)
          }) {
            Text(item.rawValue)
              .notoSans(.subhead_3)
              .foregroundStyle(selectedSubcategory == item ? .primary700 : .greyScale700)
          }
          .buttonStyle(.plain)
        }
      }
      .padding(.horizontal, 56)
    }
    .padding(.top, 22)
  }
}
