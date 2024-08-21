//
//  MyPageView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct MyPageView: View {
  private let store: StoreOf<MyPageStore>
  
  public init(store: StoreOf<MyPageStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("마이페이지")
      }
    }
  }
}
