//
//  SearchArticleView.swift
//  FeatureArticle
//
//  Created by eunpyo on 4/23/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct SearchArticleView: View {
  @Bindable private var store: StoreOf<SearchArticleStore>

  public init(store: StoreOf<SearchArticleStore>) {
    self.store = store
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text("아티클 검색")
    }
  }
}
