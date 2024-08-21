//
//  base.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/13
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct ChatView: View {
  @Bindable var store: StoreOf<ChatStore>
  
  public init(store: StoreOf<ChatStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack {
        Text("채팅")
      }
    }
  }
}
