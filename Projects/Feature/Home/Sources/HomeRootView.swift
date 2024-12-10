//
//  HomeRootView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/20
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HomeRootView: View {
  @Bindable public var store: StoreOf<HomeRootStore>
  
  public init(store: StoreOf<HomeRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      HomeView(store: store.scope(state: \.home, action: \.home))
    } destination: { store in
      switch store.case {
      case .detailChecklist(let store):
        DetailChecklistView(store: store)
          .navigationBarBackButtonHidden()
      }
    }
  }
}
