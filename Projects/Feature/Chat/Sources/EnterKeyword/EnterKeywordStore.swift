//
//  EnterKeywordStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/30/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct EnterKeywordStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    var chatList: [CheckListEntity]
    
    var errorMessage: String?
    var text = ""
    
    public init(message: [CheckListEntity]) {
      self.chatList = message
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapSaveButton
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      default:
        return .none
      }
    }
  }
}
