//
//  CreateChecklistStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import CoreNetwork

@Reducer
public struct CreateChecklistStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: Checklist
    var selectedChecklist: [CheckBox] = []
    
    public init(checkListId: String) {
      self.checkList = .init(id: checkListId)
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case onCompleteGetChecklist(TaskResult<Checklist>)
    
    case didTapReCreateButton
    case didTapChecklist(CheckBox)
    
    case didTapSaveButton
    case onCompleteSaveButton([CheckBox])
    case pushEnterKeyword(Checklist)
    
    // navigation
    case didTapBackButton
    case pop
  }
  
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onAppear:
        let checkListId = state.checkList.id
        return .run { send in
          do {
            let checkList = try await checklistAPIClient.getChecklist(checkListId)
            await send(.onCompleteGetChecklist(.success(checkList)))
          } catch {
            await send(.onCompleteGetChecklist(.failure(error)))
          }
        }
      case .onCompleteGetChecklist(.success(let list)):
        state.checkList = list
        return .none
      case .onCompleteGetChecklist(.failure):
        return .none
      case .didTapChecklist(let selected):
        if let index = state.selectedChecklist.firstIndex(of: selected) {
          state.selectedChecklist.remove(at: index)
        } else {
          state.selectedChecklist.append(selected)
        }
        return .none
      case .didTapSaveButton:
        let checkListId = state.checkList.id
        let deleteCheckBoxList = state.checkList.checkBoxList.filter { !state.selectedChecklist.contains($0)
        }.map { $0.id }
        let selectCheckBoxList = state.selectedChecklist
        return .run { send in
          do {
            _ = try await checklistAPIClient.deleteChecklist(
              checkListId: checkListId,
              checkBoxList: deleteCheckBoxList
            )
            await send(.onCompleteSaveButton(selectCheckBoxList))
          } catch {
            print(error.localizedDescription)
          }
        }
      case .onCompleteSaveButton(let list):
        state.checkList.checkBoxList = list
        return .send(.pushEnterKeyword(state.checkList))
        
      case .didTapBackButton:
        return .send(.pop)
      default:
        return .none
      }
    }
  }
}
