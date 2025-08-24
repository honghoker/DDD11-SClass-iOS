//
//  HomeView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem
import SharedUtils

import ComposableArchitecture

struct HomeView: View {
  @Bindable private var store: StoreOf<HomeStore>

  init(store: StoreOf<HomeStore>) {
    self.store = store
  }

  var body: some View {
    GeometryReader { geometry in
      backgroundView(size: geometry.size)

      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          HeaderView(store: store)
          content(width: geometry.size.width)
        }
      }
      .refreshable {
        store.send(.onRefresh)
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .fullScreenCover(item: $store.selectedArticle) { article in
      ArticleWebView(
        title: article.title,
        url: article.url,
        didTapClose: {
          store.send(.didTapArticleWebViewCloseButton)
        }
      )
    }
  }

  private func backgroundView(size: CGSize) -> some View {
    Image.homeBackground
      .resizable()
      .scaledToFill()
      .frame(width: size.width, height: size.height)
  }

  @ViewBuilder
  private func content(width: CGFloat) -> some View {
    VStack(spacing: .zero) {
      Spacer().frame(height: 14)

      if store.isFetching {
        SkeletonContentView(width: width)
      } else {
        VStack(spacing: 20) {
          ChecklistList(store: store, width: width)
          ArticleList(store: store)
        }
      }
    }
    .frame(width: width)
    .background(.greyScale0)
    .clipShape(
      .rect(
        topLeadingRadius: 20,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0,
        topTrailingRadius: 20
      )
    )
  }
}
