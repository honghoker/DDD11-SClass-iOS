//
//  ArticleSearchResultsView.swift
//  FeatureArticle
//
//  Created by eunpyo on 6/3/25.
//

import SwiftUI

import CoreCommon
import SharedDesignSystem
import SharedUtils

import ComposableArchitecture
import Kingfisher

struct ArticleSearchResultsView: View {
  @Bindable private var store: StoreOf<ArticleSearchResultsStore>
  
  public init(store: StoreOf<ArticleSearchResultsStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      navigationBar
      contentView
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
  }

  @ViewBuilder
  private var contentView: some View {
    if store.isFetching {
      skeletonView
    } else if store.articles.isEmpty {
      articleEmptyView
    } else {
      articleList
    }
  }

  private var skeletonView: some View {
    GeometryReader { geometry in
      SkeletonArticleListView(width: geometry.size.width)
        .padding(.horizontal, 16)
    }
  }

  private var navigationBar: some View {
    HStack(spacing: .zero) {
      Button(action: {
        store.send(.didTapBackButton)
      }) {
        Image.left
          .resizable()
          .scaledToFit()
          .foregroundStyle(.greyScale950)
      }
      .frame(width: 24, height: 24)
      
      Spacer(minLength: 65)
      
      Text(store.searchTerms)
        .notoSans(.subhead_4)
        .foregroundStyle(.greyScale950)
        .lineLimit(1)
      
      Spacer(minLength: 65)
      
      EmptyView()
    }
    .padding(.vertical, 15)
    .padding(.horizontal, 20)
    .overlay(alignment: .bottom) {
      Divider()
        .background(Color.init(hex: "F4F4F4"))
    }
  }
  
  private var articleEmptyView: some View {
    VStack(spacing: 12) {
      Image.emptyResults
        .resizable()
        .scaledToFit()
        .frame(width: 168, height: 124)
      
      Text("검색 결과가 없습니다.")
        .notoSans(.body_long_1)
        .foregroundStyle(.greyScale950)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  private var articleList: some View {
    List {
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
