//
//  ArticleView.swift
//  FeatureArticle
//
//  Created by eunpyo on 3/15/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct ArticleView: View {
  private let store: StoreOf<ArticleStore>

  public init(store: StoreOf<ArticleStore>) {
    self.store = store
  }

  public var body: some View {
    VStack {
      
    }
  }
}
