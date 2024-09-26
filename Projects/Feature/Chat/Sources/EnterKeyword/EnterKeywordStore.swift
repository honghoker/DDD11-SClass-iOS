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
    var checklist: Checklist
    
    var errorMessage: String?
    var text = ""
    
    public init(checklist: Checklist) {
      self.checklist = checklist
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case didTapSaveButton
    case onCompleteTapSaveButton
    case onCloseView(checklist: Checklist)
    
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
        let checklistID = state.checklist.id
        let keyword = state.text
        return .run { send in
          do {
            try await checklistAPIClient.changeKeyword(checklistId: checklistID, newKeyword: keyword)
            await send(.onCompleteTapSaveButton)
          } catch {
            print(error.localizedDescription)
          }
        }
      case .onCompleteTapSaveButton:
        return .send(.onCloseView(checklist: state.checklist))
        
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
