//
//  HomeView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/20
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
  public let store: StoreOf<HomeStore>
  
  public init(store: StoreOf<HomeStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      Text("홈")
    }
  }
}
