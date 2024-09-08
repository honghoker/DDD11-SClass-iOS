//
//  SplashView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/09/06
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import ComposableArchitecture

public struct SplashView: View {
  private let store: StoreOf<SplashStore>
  
  public init(store: StoreOf<SplashStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack {
      
    }
    .onAppear {
      store.send(.onAppear)
    }
  }
}
