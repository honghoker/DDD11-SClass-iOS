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
    var checkListId: String
    var checkList: [CheckList] = []
    var selectedCheckList: [CheckList] = []
    
    public init(checkListId: String) {
      self.checkListId = checkListId
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case onAppear
    case onCompleteGetCheckList(TaskResult<[CheckList]>)
    
    case didTapReCreateButton
    case didTapCheckList(CheckList)
    
    case didTapSaveButton
  }
  
  @Dependency(CheckListAPIClient.self) var checkListAPIClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onAppear:
        let checkListId = state.checkListId
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
