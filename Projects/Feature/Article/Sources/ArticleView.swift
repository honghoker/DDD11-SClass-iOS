//
//  ArticleView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/31
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct ArticleView: View {
  @Bindable var store: StoreOf<ArticleStore>
  
  public init(store: StoreOf<ArticleStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("아티클")
      }
    }
  }
}
