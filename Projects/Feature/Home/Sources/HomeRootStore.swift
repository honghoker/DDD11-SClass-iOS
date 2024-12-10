//
//  HomeRootStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 7/27/24.
//

import Foundation
import ComposableArchitecture

import CoreDomain

@Reducer
public struct HomeRootStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var path = StackState<Path.State>()
    var home: HomeStore.State = .init()
    var detailChecklist: DetailChecklistStore.State?
    
    public init() {
      
    }
  }
  
  public enum Action {
    case path(StackActionOf<Path>)
    case home(HomeStore.Action)
    case detailChecklist(DetailChecklistStore.Action)
    
    case onPresentChat
    case onAppendChecklist(checklist: Checklist)
    
    // MARK: - Navigation
    
    case navigateToDetailChecklist(card: Card)
  }
  
  @Reducer
  public enum Path {
    case detailChecklist(DetailChecklistStore)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
        
      case let .path(action):
        return handlePathAction(state: &state, action: action)
        
      case let .home(action):
        switch action {
        case .onPresentChat:
          return .send(.onPresentChat)
          
        case .onNaviagteToDetailChecklist(let card):
          return .send(.navigateToDetailChecklist(card: card))
        
        default:
          return .none
        }
        
      case .onAppendChecklist(let checklist):
        return .send(.home(.onAppendChecklist(checklist: checklist)))
        
      case .navigateToDetailChecklist(let card):
        state.path.append(.detailChecklist(.init(card: card)))
        return .none
        
      default:
        return .none
      }
    }
    .forEach(\.path, action: \.path)
    .ifLet(\.detailChecklist, action: \.detailChecklist) {
      DetailChecklistStore()
    }
    
    Scope(state: \.home, action: \.home) {
      HomeStore()
    }
  }
  
  private func handlePathAction(state: inout State, action: StackActionOf<Path>) -> Effect<Action> {
    switch action {
    case .element(_, let action):
      switch action {
      case .detailChecklist(.pop):
        state.path.removeLast()
        return .none
        
      case .detailChecklist(.onComplete(let checkBox)):
        return .send(.home(.onCompleteCheckBox(checkBox: checkBox)))
        
      case .detailChecklist(.onDelete(let checkBox)):
        return .send(.home(.onDeleteCheckBox(checkBox: checkBox)))
        
      case .detailChecklist(.onDeleteLast(let card)):
        return .send(.home(.onDeleteCard(card: card)))
        
      default:
        return .none
      }
    
    default:
      return .none
    }
  }
}
