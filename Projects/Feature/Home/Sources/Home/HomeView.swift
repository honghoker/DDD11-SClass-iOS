//
//  HomeView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation
import SwiftUI

import ComposableArchitecture

struct HomeView: View {
  @Bindable private var store: StoreOf<HomeStore>
  
  init(store: StoreOf<HomeStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack {
      
    }
  }
}
