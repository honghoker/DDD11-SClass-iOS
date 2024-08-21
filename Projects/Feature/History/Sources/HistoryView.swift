//
//  HistoryView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HistoryView: View {
  private let store: StoreOf<HistoryStore>
  
  public init(store: StoreOf<HistoryStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("기록")
      }
    }
  }
}
