//
//  HomeView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation
import SwiftUI

import SharedDesignSystem

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
        VStack(spacing: 16) {
          header
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
  
  func backgroundView(size: CGSize) -> some View {
    Image.homeBackground
      .resizable()
      .scaledToFill()
      .frame(width: size.width, height: size.height)
  }
  
  private var header: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("나의 업무폴더")
        .notoSans(.display_2)
        .foregroundStyle(.white)
      
      Button(action: {
        store.send(.didTapAppendFolderButton)
      }) {
        VStack(spacing: 4) {
          Image.appendFolder
            .resizable()
            .scaledToFit()
            .frame(width: 33, height: 33)
          
          VStack(spacing: .zero) {
            Text("폴더 추가하기")
              .notoSans(.subhead_3)
              .foregroundStyle(.primary600)
            
            Text("채팅을 통해 업무 폴더를 생성해보세요")
              .notoSans(.body_1)
              .foregroundStyle(.greyScale400)
          }
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: 162)
      .background(.greyScale050)
      .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.top, 28)
    .padding(.horizontal, 16)
  }
  
  @ViewBuilder
  private func content(size: CGSize) -> some View {
    VStack(spacing: .zero) {
      Spacer().frame(height: 24)
      
      articleList
    }
    .background(.white)
    .clipShape(
      .rect(
        topLeadingRadius: 20,
        bottomLeadingRadius: 0,
        bottomTrailingRadius: 0,
        topTrailingRadius: 20
      )
    )
  }
  
  private var articleList: some View {
    VStack(spacing: 16) {
      ListSection(
        title: "관련 아티클",
        onTap: {}
      )
      
      ForEach(store.articles) { article in
        Button(action: {
          store.send(.didTapArticle(article))
        } ) {
          ArticleCellView(
            thumbnail: { ThumbnailImage(urlString: article.thumbnailURL) },
            title: article.title,
            category: article.category,
            platform: article.platform,
            postDate: article.postDate.formatted(using: .shortForm),
            url: article.url
          )
        }
      }
    }
  }
}
