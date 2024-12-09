//
//  HomeView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation
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
          content(size: geometry.size)
        }
      }
    }
    .onAppear {
      store.send(.onAppear)
    }
    .fullScreenCover(item: $store.selectedArticle) { article in
      HomeArticleWebView(
        store: store,
        article: article
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
  private func content(size: CGSize) -> some View {
    VStack(spacing: .zero) {
      Spacer().frame(height: 14)
      
      if store.isLoading {
        SkeletonContentView(width: size.width)
      } else {
        VStack(spacing: 20) {
          if let selectedCard = store.selectedCard {
            checklistList(selectedCard: selectedCard)
          }
          
          articleList
        }
      }
    }
    .frame(width: size.width)
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
  
  @ViewBuilder
  private func checklistList(selectedCard: CardModel) -> some View {
    VStack(spacing: 16) {
      ListSection(
        title: selectedCard.title,
        onTap: {
          // TODO: - 해당 업무 폴더 편집 화면으로 이동
        }
      )
      
      ForEach(store.displayedCheckBoxes) { checkBox in
        ColorChecklistCellView(
          title: checkBox.label,
          isSelected: checkBox.isCompleted,
          onTap: {
            store.send(.didTapChecklistCompleteButton(checkBox: checkBox))
          }
        )
      }
      .padding(.horizontal, 16)
      .animation(.easeIn, value: store.state.displayedCheckBoxes)
    }
  }
  
  private var articleList: some View {
    VStack(spacing: 16) {
      ListSection(
        title: "관련 아티클",
        onTap: {}
      )
      
      ForEach(store.articles) { article in
        ArticleCellView(
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
