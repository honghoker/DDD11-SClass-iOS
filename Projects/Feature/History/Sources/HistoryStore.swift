//
//  HistoryStore.swift
//  FeatureHistory
//
//  Created by 홍은표 on 8/9/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct HistoryStore {
  public init() { }
  
  @ObservableState
  public struct State {
    public init() {
      
    }
  }
  
  public enum Action {
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }
}
