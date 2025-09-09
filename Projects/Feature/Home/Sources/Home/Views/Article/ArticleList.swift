//
//  ArticleList.swift
//  FeatureHome
//
//  Created by eunpyo on 8/25/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct ArticleList: View {
  @Bindable private var store: StoreOf<HomeStore>

  init(store: StoreOf<HomeStore>) {
    self.store = store
  }

  var body: some View {
    VStack(spacing: 16) {
      HStack(spacing: 8) {
        Text("인기 아티클")
          .notoSans(.subhead_4)
          .foregroundStyle(.greyScale950)

        Spacer()
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 16)

      ForEach(store.articles) { article in
        MainArticleCellView(
          thumbnail: { ThumbnailImage(urlString: article.thumbnailURL) },
          title: article.title,
          category: article.category,
          platform: article.platform,
          postDate: article.postDate.formatted(using: .shortForm),
          url: article.url,
          onTap: {
            store.send(.didTapArticle(article))
          }
        )
      }
    }
  }
}
