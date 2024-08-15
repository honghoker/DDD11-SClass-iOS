//
//  HomeStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 7/27/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct HomeStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var path = StackState<Path.State>()
    
    public init() {
      
    }
  }
  
  public enum Action {
    case path(StackActionOf<Path>)
  }
  
  @Reducer
  public enum Path {
    
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}
