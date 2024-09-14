//
//  ChatNavigationStore.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/31/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import SharedDesignSystem

public extension ChatNavigationStore {
  @Reducer
  public enum ChatPath {
    case createCheckList(CreateCheckListStore)
    case enterKeyword(EnterKeywordStore)
  }
}

@Reducer
public struct ChatNavigationStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var path = StackState<ChatPath.State>()
    public var chat: ChatStore.State = .init()
    public var checkList: CreateCheckListStore.State = .init(checkListId: "")
    public var enterKeyword: EnterKeywordStore.State = .init(checkList: .init(id: "", checkBoxList: []))
    public init() {
    }
  }
  
  public enum Action {
    case path(StackActionOf<ChatPath>)
    case initializeChat
    
    case chat(ChatStore.Action)
    case checkList(CreateCheckListStore.Action)
    case enterKeyword(EnterKeywordStore.Action)
    
    case pop
  }
  
  public var body: some ReducerOf<Self> {
    
    Scope(state: \.chat, action: \.chat) {
      ChatStore()
    }
    
    Scope(state: \.checkList, action: \.checkList) {
      CreateCheckListStore()
    }
    
    Scope(state: \.enterKeyword, action: \.enterKeyword) {
      EnterKeywordStore()
    }
    
    Reduce { state, action in
      switch action {
      case .initializeChat:
        state.chat = ChatStore.State()
        return .none
      case .path(_):
        return .none
      case .pop:
        state.path.removeLast()
        return .none
        
      case .chat(.onCompleteCreateCheckList(let id)):
        state.checkList = CreateCheckListStore.State(checkListId: id)
        state.path.append(.createCheckList(state.checkList))
        return .none
      case .checkList(.pushEnterKeyword(let checkList)):
        state.enterKeyword = .init(checkList: checkList)
        state.path.append(.enterKeyword(state.enterKeyword))
        return .none
        
      case .checkList(.pop), .enterKeyword(.pop):
        state.path.removeLast()
        return .none
      case .chat(_):
        return .none
      case .checkList(_):
        return .none
      case .enterKeyword(_):
        return .none
      }
    }
    .forEach(\.path, action: \.path)
  }
}

