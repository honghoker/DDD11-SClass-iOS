//
//  HistoryStore.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/12/24.
//

import Foundation
import ComposableArchitecture

import CoreDomain

@Reducer
public struct HistoryStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: [Checklist] = []
    var selected: Checklist? = .none
    var showModal = false
    var showEditTitleModal = false
    var showDeleteAlert = false
    var newTitle: String = ""
    var isActive: Bool {
      3...8 ~= newTitle.count
    }
    public init() {
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case didTapCheckList(Checklist)
    
    // bottomsheet 처리
    case didTapDismiss
    case didTapDelete
    case didTapEditTitle
    
    // alert 처리
    case didTapDeleteConfirm
    case didTapDeleteCancel
    
    // 제목변경 처리
    case didTapEditTitleConfirm
    case didTapEditTitleCancel
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        state.checkList = [
          .mock1,
          .mock2,
          .init(id: UUID().uuidString, title: "요청/문의", checkBoxList: []),
          .init(id: UUID().uuidString, title: "보고/컴펌", checkBoxList: []),
          .init(id: UUID().uuidString, title: "협업", checkBoxList: []),
          .init(id: UUID().uuidString, title: "커뮤니케이션", checkBoxList: []),
          .init(id: UUID().uuidString, title: "인터렉션 디자인", checkBoxList: []),
          .init(id: UUID().uuidString, title: "예시용 체크리스트", checkBoxList: []),
        ]
        return .none
        
      case .didTapCheckList(let selected):
        state.selected = selected
        state.showModal = true
        state.showEditTitleModal = false
        return .none
        
      case .didTapEditTitle:
        state.showModal = false
        state.showEditTitleModal = true
        state.newTitle = state.selected?.title ?? ""
        return .none
        
      case .didTapDelete:
        state.showModal = false
        state.showDeleteAlert = true
        return .none
        
      case .didTapDeleteConfirm:
        if let selected = state.selected,
           let index = state.checkList.firstIndex(of: selected) {
          state.checkList.remove(at: index)
        }
        state.selected = nil
        return .none
        
      case .didTapDeleteCancel:
        state.showDeleteAlert = false
        state.selected = nil
        return .none
        
      case .didTapEditTitleConfirm:
        state.showEditTitleModal = false
        if let selected = state.selected,
           let index = state.checkList.firstIndex(of: selected) {
          state.checkList[index].title = state.newTitle
        }
        state.selected = nil
        return .none
        
      case .didTapEditTitleCancel:
        state.showEditTitleModal = false
        state.selected = nil
        return .none
        
      case .didTapDismiss:
        state.showModal = false
        state.showEditTitleModal = false
        state.showDeleteAlert = false
        state.selected = nil
        return .none
        
      }
    }
  }
}
