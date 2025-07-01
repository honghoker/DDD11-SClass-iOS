//
//  HistoryDetailStore.swift
//  FeatureHistory
//
//  Created by 현수빈 on 11/25/24.
//

import Foundation

import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct HistoryDetailStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var checkList: Checklist
    var article: [MainArticle]
    var selected: CheckBox?
    var modal: ModalType? = .none
    var newTitle: String = ""
    var currentTab: TabItem = .checklist
    var isActive: Bool {
      newTitle.count != 0 &&
      newTitle != selected?.label
    }
    var isLoading = true
    
    public init(checklist: Checklist) {
      self.checkList = checklist
      self.article = []
      self.selected = nil
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case onAppearFinish([CheckBox], [MainArticle])
    
    case didTapChangeCurrentTab(TabItem)
    
    // MARK: - 체크박스 완료
    case didTapChecklistComplete(CheckBox)
    case didTapChecklistCompleteServer(Int)
    
    // MARK: - bottomsheet 처리
    case didTapDismiss
    
    // MARK: - 체크박스 삭제 처리
    case didTapDelete(CheckBox)
    case didTapDeleteConfirm
    case didTapDeleteServer(Int)
    case didTapDeleteCancel
    
    // MARK: - 체크박스 타이틀 변경 처리
    case didTapEditTitle(CheckBox)
    case didTapEditTitleConfirm
    case didTapEditTitleServer(Int)
    case didTapEditTitleCancel
    
    // MARK: - Navigation
    case didTapBackButton
    case didTapArticle(MainArticle)
  }
  
  public enum ModalType: Identifiable {
    public var id: Self { return self }
    case delete
    case editTitle
  }
  
  
 @Dependency(ChecklistAPIClient.self) var checklistAPIClient
 @Dependency(HomeAPIClient.self) var homeAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        let id = state.checkList.id
        return .run { send in
          do {
            async let checkBoxListResponse = try  checklistAPIClient.getChecklistItemList(id: id)
            async let articleListResponse = try homeAPIClient.fetchArticles()
            
            let (checkBoxList, articleList) = try await ( checkBoxListResponse, articleListResponse
            )
            return await send(.onAppearFinish(checkBoxList, articleList))
          } catch {
            return await send(.onAppearFinish([], []))
          }
        }
        
      case .onAppearFinish(let list, let articleList):
        state.checkList.checkBoxList = list
        state.article = articleList
        state.isLoading = false
        return .none
        
      case .didTapChangeCurrentTab(let newTab):
          state.currentTab = newTab
        return .none
        
      case .didTapChecklistComplete(let checkBox):
        guard let index = state.checkList.checkBoxList
          .firstIndex(where: { $0 == checkBox })
        else {
          return .none
        }
        state.isLoading = true
        let checklistId = state.checkList.id
        let updateState = !state.checkList.checkBoxList[index].isCompleted
        return .run { send in
          do {
            try await checklistAPIClient.complete(
                checklistId,
                checkBox.id,
                updateState
            )
            await send(.didTapChecklistCompleteServer(index))
          } catch {
            debugPrint(error.localizedDescription)
          }
        }
        
      case .didTapChecklistCompleteServer(let index):
        state.checkList.checkBoxList[index].isCompleted.toggle()
        state.isLoading = false
        return .none
        
      case .didTapEditTitle(let selected):
        state.selected = selected
        state.modal = .editTitle
        state.newTitle = state.selected?.label ?? ""
        return .none
        
      case .didTapDelete(let selected):
        state.selected = selected
        state.modal = .delete
        return .none
        
      case .didTapDeleteConfirm:
        guard let selected = state.selected,
           let index = state.checkList.checkBoxList.firstIndex(of: selected)
        else { return .none }
        state.isLoading = true
        return .run { [checkList = state.checkList] send in
          do {
            try await checklistAPIClient.deleteChecklist(
              checkList.id,
              selected.id
            )
            await send(.didTapDeleteServer(index))
          } catch {
            debugPrint(error.localizedDescription)
          }
        }
        
      case .didTapDeleteServer(let index):
        state.checkList.checkBoxList.remove(at: index)
        state.selected = nil
        state.isLoading = false
        return .none
        
      case .didTapDeleteCancel:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapEditTitleConfirm:
        state.modal = nil
        guard let selected = state.selected,
           let index = state.checkList.checkBoxList.firstIndex(of: selected)
        else { return .none }
        state.isLoading = true
         
        return .run { [title = state.newTitle] send in
          do {
            try await checklistAPIClient.changeItemKeyword(
              selected.checklistId,
              selected.id,
              title
            )
            await send(.didTapEditTitleServer(index))
          } catch {
            debugPrint(error.localizedDescription)
          }
        }
        
      case .didTapEditTitleServer(let index):
        state.checkList.checkBoxList[index].label = state.newTitle
        state.selected = nil
        state.isLoading = false
        return .none
        
      case .didTapEditTitleCancel:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapDismiss:
        state.modal = nil
        state.selected = nil
        return .none
        
      case .didTapBackButton:
        return .none
        
      case .didTapArticle(_):
        return .none
      }
    }
  }
}

public enum TabItem: CaseIterable {
  case checklist
  case article
  
  var title: String {
    switch self {
    case .checklist:
      return "체크리스트"
    case .article:
      return "아티클"
    }
  }
}
