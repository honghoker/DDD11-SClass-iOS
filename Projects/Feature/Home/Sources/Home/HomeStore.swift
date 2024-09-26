//
//  HomeStore.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreCommon
import CoreDomain
import CoreNetwork

import ComposableArchitecture

@Reducer
public struct HomeStore {
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    var cards: [CardModel] = []
    var articles: [Article] = []
    var selectedArticle: Article?
    var selectedCard: CardModel?
    var displayedCheckBoxes: [CheckBox] = []
    var isViewDidLoad: Bool = false
    var isLoading: Bool = true
    
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case onAppear
    case didTapAppendFolderButton
    case onPresentChat
    case didTapArticle(Article)
    case didTapArticleExitButton
    case setCards([Checklist])
    case setArticles([Article])
    case setSelectedCard(card: CardModel)
    case didTapProjectFolder(card: CardModel)
    case didTapChecklistCompleteButton(checkBox: CheckBox)
    case isLoadingChanged(isLoading: Bool)
    case onAppendChecklist(checklist: Checklist)
  }
  
  public init() {}
  
  @Dependency(HomeAPIClient.self) var homeAPIClient
  @Dependency(ChecklistAPIClient.self) var checklistAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
        
      case .onAppear:
        guard !state.isViewDidLoad else {
          return .none
        }
        
        state.isViewDidLoad = true
        
        guard let userID = state.userInfo?.userID else {
          return .none
        }
        
        return .run { send in
          await send(.isLoadingChanged(isLoading: true))
//          async let checklistsReponse = try checklistAPIClient.getChecklists(userID: userID)
          async let articlesReponse = try homeAPIClient.fetchArticles(userID)
          
          let (
            checklists,
            articles
          ) = try await (
            [Checklist.mock1, Checklist.mock2],
//            checklistsReponse,
            articlesReponse
          )
          
          await send(.setCards(checklists))
          await send(.setArticles(articles))
          await send(.isLoadingChanged(isLoading: false))
        } catch: { error, send in
          print(error)
          await send(.isLoadingChanged(isLoading: false))
        }
      
      case .setCards(let checklists):
        state.cards = checklists.map {
          .init(id: $0.id, title: $0.title, checkBoxList: $0.checkBoxList)
        }
        
        guard let firstCard = state.cards.first else {
          return .none
        }
        
        // 첫 번째 카드를 선택된 카드로 설정
        return .send(.setSelectedCard(card: firstCard))
        
      case .setArticles(let articles):
        state.articles = Array(articles.prefix(3))
        return .none
        
      case .didTapAppendFolderButton:
        return .send(.onPresentChat)
        
      case .didTapProjectFolder(let card):
        state.selectedCard = card
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        return .none
        
      case .didTapChecklistCompleteButton(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0.id == state.selectedCard?.id }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }
        
        state.cards[selectedCardIndex].checkBoxList[checkBoxIndex].isCompleted.toggle()
        state.cards[selectedCardIndex].calculatePercent()
        state.selectedCard = state.cards[selectedCardIndex]
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: state.cards[selectedCardIndex])
        
        return .run { send in
          _ = try await checklistAPIClient.complete(
            checklistId: checkBox.checklistId,
            id: checkBox.id,
            completed: checkBox.isCompleted
          )
        } catch: { error, send in
          
        }
        
      case .setSelectedCard(let card):
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        state.selectedCard = card
        return .none
      case .didTapArticle(let article):
        state.selectedArticle = article
        return .none

      case .didTapArticleExitButton:
        state.selectedArticle = .none
        return .none
        
      case .isLoadingChanged(let isLoading):
        state.isLoading = isLoading
        return .none
        
      case .onAppendChecklist(let checklist):
        let card = CardModel(
          id: checklist.id,
          title: checklist.title,
          checkBoxList: checklist.checkBoxList
        )
        
        state.cards.insert(card, at: 0)
        
        return .none
        
      default:
        return .none
      }
    }
  }
}

extension HomeStore {
  func calculateDisplayedCheckBoxes(for card: CardModel) -> [CheckBox] {
    let checkBoxList = card.checkBoxList
    let needDisplayCount = 3
    
    let checkBoxes: [CheckBox] = .init(checkBoxList.filter { !$0.isCompleted }.prefix(needDisplayCount))
    
    guard checkBoxes.count != needDisplayCount else {
      /// 완료되지 않은 체크박스가 3개인 경우 반환
      return checkBoxes
    }
    
    guard let startIndex = checkBoxList.firstIndex(where: { !$0.isCompleted }) else {
      /// 모든 체크박스가 완료된 경우, 배열의 끝에서부터 3개의 체크박스를 반환
      return checkBoxList.suffix(needDisplayCount)
    }
    
    guard startIndex + needDisplayCount < checkBoxList.count else {
      /// 가장 첫번째로 완료되지 않은 체크박스 기준에서 3개를 보여줄 수 없다면, 배열의 끝에서부터 3개의 체크박스를 반환
      return checkBoxList.suffix(needDisplayCount)
    }
    
    let endIndex = startIndex + needDisplayCount
    
    return Array(checkBoxList[startIndex..<endIndex])
  }
}
