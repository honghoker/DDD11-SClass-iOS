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
    VStack(alignment: .leading, spacing: 16) {
      ArticleTopNavigation(
        title: "아티클",
        onTapSearch: {
          store.send(.didTapSearchButton)
        }
      )

      VStack(alignment: .leading, spacing: 14) {
        categoryButtons

        articleList
      }
    }
    .contextMenu(
      isPresented: store.shareContextMenu.isPresented,
      anchorFrame: store.shareContextMenu.anchorFrame,
      items: [
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
      ],
      alignment: .top,
      onOutsideTap: {
        store.send(.didTapOutsidePopup)
      }
    )
    .contextMenu(
      isPresented: store.sortContextMenu.isPresented,
      anchorFrame: store.sortContextMenu.anchorFrame,
      items: [
        .init(
          icon: nil,
          title: "최신순",
          action: {
            store.send(.didTapLatestSortButton)
          }
        ),
        .init(
          icon: nil,
          title: "인기순",
          action: {
            store.send(.didTapPopularitySortButton)
          }
        )
      ],
      alignment: .bottom,
      onOutsideTap: {
        store.send(.didTapOutsidePopup)
      }
    )
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
    .sheet(isPresented: $store.subcategorySheet.isPresented) {
      if let category = store.subcategorySheet.category {
        ArticleSelectSubcategoryBottomSheetView(
          category: category,
          selectedSubcategory: store.subcategorySheet.subcategory,
          onSelect: { subcategory in
            store.send(.didTapSubcategoryButton(subcategory))
          },
          onClose: {
            store.send(.didCloseSubcategorySheet)
          }
        )
        .presentationDetents([.height(306)])
        .presentationCornerRadius(30)
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
        ArticleSubNavigationBar(
          title: "\(store.articleHeaderTitle) 아티클",
          showOrderButton: store.selectedCategory != .all,
          isPresented: store.sortContextMenu.isPresented,
          onOpenPopup: { globalFrame in
            store.send(.didTapSortButton(globalFrame: globalFrame))
          }
        )

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
            isPopupOpen: store.selectedShareArticleId == article.id,
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
}
