//
//  HomeArticleWebView.swift
//  FeatureHome
//
//  Created by 현수빈 on 9/25/24.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

struct HomeArticleWebView: View {
  @Bindable private var store: StoreOf<HomeStore>
  @State private var showShareSheet: Bool = false
  private let article: Article
  
  init(store: StoreOf<HomeStore>, article: Article) {
    self.store = store
    self.article = article
  }
  
  var body: some View {
    VStack {
      TopArticleNavigation(
        title: article.title,
        url: article.url,
        leftAction: {
          store.send(.didTapArticleExitButton)
        }
      )
      .padding()
      WebViewRepresentable(url: article.url)
    }
    
  }
}
