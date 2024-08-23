//
//  HomeView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/07/20
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem

public struct HomeView: View {
  public let store: StoreOf<HomeStore>
  
  @State var text: String = ""
  @FocusState var isFocused: Bool
  
  public init(store: StoreOf<HomeStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      Text("홈")
      
      ChatInputView(
        text: $text,
        action: {},
        isFocused: $isFocused
      )
      .focused($isFocused)
      .padding()
    }
  }
}
