//
//  MyPageRootView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MyPageRootView: View {
  @Bindable private var store: StoreOf<MyPageRootStore>
  
  public init(store: StoreOf<MyPageRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
      MyPageView(store: store.scope(state: \.myPage, action: \.myPage))
    } destination: { store in
      switch store.case {
      case .legalDocument(let store):
        LegalDocumentView(store: store)
          .navigationBarBackButtonHidden()
        
      case .accountManagement(let store):
        AccountManagementView(store: store)
          .navigationBarBackButtonHidden()
      }
    }
  }
}
