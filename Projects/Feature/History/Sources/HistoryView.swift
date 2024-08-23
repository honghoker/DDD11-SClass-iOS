//
//  HistoryView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct HistoryView: View {
  private let store: StoreOf<HistoryStore>
  
  public init(store: StoreOf<HistoryStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      Image.historyEmptyView
        .resizable()
        .scaledToFit()
        .frame(width: 192, height: 186)
    }
  }
}
