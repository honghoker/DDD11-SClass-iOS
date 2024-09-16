//
//  CreateCheckListStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/28/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import CoreNetwork

@Reducer
public struct CreateCheckListStore {
  public init() { }
  
  @ObservableState
  public struct State: Equatable {
    var checkList: CheckList
    var selectedCheckList: [CheckBox] = []
    
    public init(checkListId: String) {
      self.checkList = .init(id: checkListId, checkBoxList: [])
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case onCompleteGetCheckList(TaskResult<CheckList>)
    
    case didTapReCreateButton
    case didTapCheckList(CheckBox)
    
    case didTapSaveButton
    case onCompleteSaveButton([CheckBox])
    case pushEnterKeyword(CheckList)
    
    // navigation
    case didTapBackButton
    case pop
  }
  
  @Dependency(CheckListAPIClient.self) var checkListAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onAppear:
        let checkListId = state.checkList.id
        return .run { send in
          do {
            let checkList = try await checkListAPIClient.getCheckList(checkListId)
            await send(.onCompleteGetCheckList(.success(checkList)))
          } catch {
            await send(.onCompleteGetCheckList(.failure(error)))
          }
        }
      case .onCompleteGetCheckList(.success(let list)):
        state.checkList = list
        return .none
      case .onCompleteGetCheckList(.failure):
        return .none
      case .didTapCheckList(let selected):
        if let index = state.selectedCheckList.firstIndex(of: selected) {
          state.selectedCheckList.remove(at: index)
        } else {
          state.selectedCheckList.append(selected)
        }
        return .none
      case .didTapSaveButton:
        let checkListId = state.checkList.id
        let deleteCheckBoxList = state.checkList.checkBoxList.filter { !state.selectedCheckList.contains($0)
        }.map { $0.id }
        let selectCheckBoxList = state.selectedCheckList
        return .run { send in
          do {
            _ = try await checkListAPIClient.deleteCheckList(
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
