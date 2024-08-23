//
//  ArticleView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/31
//  Copyright © 2024 DDD , Ltd., All rights reserved.
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
    NavigationStack {
      Image.articleEmptyView
        .resizable()
        .scaledToFit()
        .frame(width: 234, height: 292)
    }
  }
}
