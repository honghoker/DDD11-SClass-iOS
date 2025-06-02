//
//  ArticleRootView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/31
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct ArticleRootView: View {
  @Bindable private var store: StoreOf<ArticleRootStore>

  public init(store: StoreOf<ArticleRootStore>) {
    self.store = store
  }

  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      ArticleView(store: store.scope(state: \.article, action: \.article))
    } destination: { store in
      switch store.case {
      case .articleSearchInput(let store):
        ArticleSearchInputView(store: store)
          .navigationBarBackButtonHidden()
      }
    }
  }
}
