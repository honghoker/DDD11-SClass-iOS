//
//  RootView.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/27/24.
//

import SwiftUI
import Feature
import ComposableArchitecture

struct RootView: View {
  @Bindable var store: StoreOf<RootStore>
  
  var body: some View {
    SwitchStore(self.store) { state in
      switch state {
      case .mainTab:
        if let store = store.scope(state: \.mainTab, action: \.mainTab) {
          MainTabView(store: store)
        }
      }
    }
  }
}
