//
//  ArticleView.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

public struct ArticleView: View {
  @Bindable private var store: StoreOf<ArticleStore>

  public init(store: StoreOf<ArticleStore>) {
    self.store = store
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      categoryButtons

      Spacer()
    }
  }

  private var categoryButtons: some View {
    HStack(spacing: 6) {
      ForEach(store.categories, id: \.self) { category in
        ArticleButtonMenu(
          image: category.image,
          title: category.title,
          selectedBackgroundColor: category.selectedBackgroundColor,
          selectedStrokeColor: category.selectedStrokeColor,
          isSelected: store.selectedCategory == category,
          onTap: {
            store.send(.didTapCategoryButton(category))
          }
        )
      }

      Spacer()
    }
    .padding([.top, .horizontal], 16)
  }
}
