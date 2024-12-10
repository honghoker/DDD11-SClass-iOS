//
//  DetailChecklistStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 10/21/24.
//

import Foundation

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct DetailChecklistStore {
  
  @ObservableState
  public struct State {
    var card: Card
    var isPresentDeleteCheckBoxAlert: Bool = false
    var willDeleteCheckBox: CheckBox?
  }
  
  public enum Action: BindableAction {
    
    // MARK: - View
    
    case binding(BindingAction<State>)
    case presentDeleteCheckBoxAlert
    case dismissDeleteCheckBoxAlert
    
    // MARK: - User Actions
    
    case didTapBackButton
    case didTapChecklistCompleteButton(checkBox: CheckBox)
    case onSwipeToDeleteCheckBox(checkBox: CheckBox)
    case didTapConfirmSwipeToDeleteCheckBox
    case didTapCancelSwipeToDeleteCheckBox
    
    // MARK: - Internal Actions
    
    case deleteCheckBox(checkBox: CheckBox)
    case completeResponse(Result<CheckBox, Error>)
    
    // MARK: - Navigation
    
    case pop
    
    // MARK: - Delegate Actions(parent)
    
    case onComplete(checkBox: CheckBox)
    case onDelete(checkBox: CheckBox)
    case onDeleteLast(card: Card)
  }
  
  // MARK: - Dependencies
  
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .presentDeleteCheckBoxAlert:
        state.isPresentDeleteCheckBoxAlert = true
        return .none
        
      case .dismissDeleteCheckBoxAlert:
        state.isPresentDeleteCheckBoxAlert = false
        return .none
        
      case .didTapBackButton:
        return .send(.pop)
        
      case .didTapChecklistCompleteButton(let checkBox):
        guard let index = state.card
          .checkBoxList
          .firstIndex(where: { $0 == checkBox })
        else {
          return .none
        }
        
        state.card.checkBoxList[index].isCompleted.toggle()
        return .send(.onComplete(checkBox: checkBox))
        
      case .onSwipeToDeleteCheckBox(let checkBox):
        state.willDeleteCheckBox = checkBox
        return .send(.presentDeleteCheckBoxAlert)
        
      case .didTapConfirmSwipeToDeleteCheckBox:
        guard let checkBox = state.willDeleteCheckBox else {
          return .none
        }
        
        return .merge(
          .send(.dismissDeleteCheckBoxAlert),
          .send(.deleteCheckBox(checkBox: checkBox))
        )
        
      case .didTapCancelSwipeToDeleteCheckBox:
        return .send(.dismissDeleteCheckBoxAlert)
        
      case .deleteCheckBox(let checkBox):
        state.willDeleteCheckBox = nil
        // TODO: - API 연동 후 수정
        return .send(.completeResponse(.success(checkBox)))
        //        return .run { [cardID = state.card.id, checklistID = checkBox.checklistId] send in
        //          do {
        //            _ = try await checklistAPIClient.deleteChecklist(
        //              checklistId: cardID,
        //              checkBoxList: [checklistID]
        //            )
        //            await send(.completeResponse(.success(checkBox)))
        //          } catch {
        //            await send(.completeResponse(.failure(error)))
        //          }
        //        }
        
      case .completeResponse(.success(let checkBox)):
        if let index = state.card.checkBoxList.firstIndex(where: { $0 == checkBox }) {
          state.card.checkBoxList.remove(at: index)
        }
        
        if state.card.checkBoxList.isEmpty {
          return .merge(
            .send(.onDeleteLast(card: state.card)),
            .send(.pop)
          )
        }
        
        return .send(.onDelete(checkBox: checkBox))
        
        
      case .completeResponse(.failure):
        return .none
        
      default:
        return .none
      }
    }
  }
}
