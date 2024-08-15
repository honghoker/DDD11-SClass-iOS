//
//  ChatStore.swift
//  FeatureChat
//
//  Created by 홍은표 on 8/15/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct ChatStore {
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
