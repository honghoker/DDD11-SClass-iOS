//
//  EnterKeywordStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/30/24.
//

import Foundation

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct EnterKeywordStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: Checklist
    
    var errorMessage: String?
    var text = ""
    
    public init(checkList: Checklist) {
      self.checkList = checkList
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapSaveButton
    case onCompleteTapSaveButton
    case onCloseView
    
    case didTapBackButton
    case pop
  }
  
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .didTapSaveButton:
        let checkListId = state.checkList.id
        let keyword = state.text
        return .run { send in
          do {
            try await checklistAPIClient.changeKeyword(checkListId: checkListId, newKeyword: keyword)
            await send(.onCompleteTapSaveButton)
          } catch {
            print(error.localizedDescription)
          }
        }
      case .onCompleteTapSaveButton:
        return .send(.onCloseView)
        
      case .didTapBackButton:
        return .send(.pop)
      case .pop:
        return .none
      case .onCloseView:
        return .none
      }
    }
  }
}
