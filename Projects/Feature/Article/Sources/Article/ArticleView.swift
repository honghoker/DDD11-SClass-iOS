//
//  ArticleView.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import SwiftUI

import CoreCommon
import CoreDomain
import SharedDesignSystem
import SharedUtils

import ComposableArchitecture
import Kingfisher

public struct ArticleView: View {
  @Bindable private var store: StoreOf<ArticleStore>

  public init(store: StoreOf<ArticleStore>) {
    self.store = store
  }

  public var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 14) {
        categoryButtons

        articleList
      }

      if store.contextMenu.isPresented {
        contextMenu
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .sheet(
      isPresented: $store.isShareSheetPresented,
      onDismiss: {
        store.send(.didDismissShareSheet)
      }
    ) {
      if let url = store.shareURL {
        ActivityView(activityItems: [url])
          .presentationDetents(.init([.medium]))
      }
    }
    .fullScreenCover(item: $store.selectedArticle) { article in
      ArticleWebView(
        title: article.title,
        url: article.url,
        didTapClose: {
          store.send(.didTapArticleExitButton)
        }
      )
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

  private var articleList: some View {
    List {
      VStack(spacing: .zero) {
        HStack {
          Text(store.articleHeaderTitle)
            .notoSans(.subhead_4)
            .foregroundStyle(.greyScale950)
            .padding(.vertical, 12)

          Spacer()
        }

        Spacer().frame(height: 6)
      }
      .listRowSeparator(.hidden)

      Section {
        ForEach(store.articles) { article in
          ArticleCardView(
            thumbnailBuilder: {
              KFImage(URL(string: article.thumbnail))
                .resizable()
                .scaledToFill()
            },
            platform: article.source,
            postDate: article.postDate.formatted(using: .shortHyphenForm),
            title: article.title,
            description: article.title,
            hashtags: article.hashtags,
            isPopupOpen: store.contextMenu.openedArticleId == article.id,
            onOpenPopup: { globalFrame in
              store.send(.didTapMenuButton(articleId: article.id, globalFrame: globalFrame))
            },
            onTap: {
              store.send(.didTapArticle(article: article))
            }
          )
          .listRowSeparator(.hidden)
          .listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
        }
      }
    }
    .listStyle(.plain)
    .listRowSpacing(20)
  }

  @ViewBuilder private var contextMenu: some View {
    Color.black.opacity(0.001)
      .ignoresSafeArea()
      .layoutPriority(-1)
      .onTapGesture {
        store.send(.didTapOutsidePopup)
      }

    ContextMenuView(items: [
      .init(
        icon: .share,
        title: "공유하기",
        action: {
          store.send(.didTapShareButton)
        }
      ),
      .init(
        icon: .copyLink,
        title: "링크 복사",
        action: {
          store.send(.didTapCopyLinkButton)
        }
      )
    ])
    .position(store.contextMenu.position)
  }
}
