//
//  CreateCheckListStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct CreateCheckListStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    var checkList: [CheckListEntity]
    var selectedCheckList: [CheckListEntity] = []
    
    public init(message: MessageEntity) {
      self.checkList = message.checkList
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case didTapReCreateButton
    case didTapCheckList(CheckListEntity)
    
    case didTapSaveButton
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .didTapCheckList(let selected):
        state.selectedCheckList.append(selected)
        return .none
      case .didTapSaveButton:
        return .none
      default:
        return .none
      }
    }
  }
}
