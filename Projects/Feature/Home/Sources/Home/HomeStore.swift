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
    var isViewDidLoaded = false
    var isFetching: Bool = true
    var isFetchingChecklistItems: Bool = false

    var cards: IdentifiedArrayOf<Card> = []
    var articles: IdentifiedArrayOf<MainArticle> = []
    var displayedCheckBoxes: IdentifiedArrayOf<CheckBox> = []

    var selectedCard: Card?
    var selectedArticle: MainArticle?

    public init() {}
  }

  public enum Action: BindableAction {

    // MARK: - Life Cycle

    case onAppear

    // MARK: - View

    case binding(BindingAction<State>)
    case detailChecklist(DetailChecklistStore.Action)

    // MARK: - User Actions

    case onRefresh
    case didTapAppendFolderButton
    case didTapArticle(MainArticle)
    case didTapArticleWebViewCloseButton
    case didTapChecklistCard(card: Card)
    case didTapChecklistCompleteButton(checkBox: CheckBox)
    case didTapNavigateToDetailChecklist(card: Card)

    // MARK: - Internal Actions

    case isFetchingChanged(isFetching: Bool)
    case isFetchingChecklistItemsChanged(isFetching: Bool)

    /// Checklist
    case setChecklistCards([Card])
    case selectChecklist(card: Card?)
    case onAppendNewChecklist(checklist: Checklist)
    case updateSelectedCardAfterDelay(index: Int)
    case completeCheckBox(checkBox: CheckBox)
    case deleteCheckBox(checkBox: CheckBox)
    case onCompleteDeleteCard(Result<Card, Error>)
    case onCompleteFetchSelectedChecklistItems(Result<[CheckBox], Error>)

    /// Article
    case setArticles([MainArticle])

    // MARK: - Async Atcion

    case fetchData
    case fetchSelectedChecklistItems(id: String)

    // MARK: - Navigation

    case onPresentChat

    // MARK: - Delegate Actions(parent)

    case onNaviagteToDetailChecklist(card: Card)

    // MARK: - Scope Actions(child)

    case onCompleteCheckBox(checkBox: CheckBox)
    case onDeleteCheckBox(checkBox: CheckBox)
    case onDeleteCard(card: Card)
  }

  public init() {}

  // MARK: - Dependencies

  @Dependency(HomeAPIClient.self) private var homeAPIClient
  @Dependency(ChecklistAPIClient.self) private var checklistAPIClient
  @Dependency(\.continuousClock) private var clock

  public var body: some ReducerOf<Self> {
    BindingReducer()

    Reduce { state, action in
      switch action {
      case .binding:
        return .none

      case .onAppear:
        guard !state.isViewDidLoaded else {
          return .none
        }

        state.isViewDidLoaded = true
        return .send(.fetchData)

      case .onRefresh:
        return .send(.fetchData)

      case .didTapAppendFolderButton:
        return .send(.onPresentChat)

      case .didTapChecklistCard(let card):
        return .send(.selectChecklist(card: card))

      case .didTapChecklistCompleteButton(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))

      case .didTapArticle(let article):
        state.selectedArticle = article
        return .none

      case .didTapArticleWebViewCloseButton:
        state.selectedArticle = .none
        return .none

      case .didTapNavigateToDetailChecklist(let card):
        return .send(.onNaviagteToDetailChecklist(card: card))

      case .fetchData:
        return .run { send in
          await send(.isFetchingChanged(isFetching: true))

          do {
            async let checklistsStatusResponse = try homeAPIClient.fetchChecklistsStatus()
            async let articlesResponse = try homeAPIClient.fetchArticles()

            let (checklistsStatus, articles) = try await (checklistsStatusResponse, articlesResponse)

            let cards = checklistsStatus.map(\.toCard)

            await send(.setChecklistCards(cards))
            await send(.setArticles(articles))
          } catch {
            debugPrint("HomeStore onAppear failed: \(error.localizedDescription)")
          }

          await send(.isFetchingChanged(isFetching: false))
        }

      case .setChecklistCards(let cards):
        state.cards = .init(uniqueElements: cards)

        // 첫 번째 카드를 선택된 카드로 설정
        if let card = state.cards.first {
          return .send(.selectChecklist(card: card))
        }

        return .none

      case .setArticles(let articles):
        state.articles = .init(uniqueElements: Array(articles.prefix(3)))
        return .none

      case .selectChecklist(let card):
        state.selectedCard = card

        if let card, card.checkBoxList.isEmpty {
          return .send(.fetchSelectedChecklistItems(id: card.id))
        }

        state.displayedCheckBoxes = card?.fetchDisplayedCheckBoxes() ?? []
        return .none

      case .fetchSelectedChecklistItems(let id):
        return .run { send in
          do {
            await send(.isFetchingChecklistItemsChanged(isFetching: true))
            let checkboxes = try await checklistAPIClient.getChecklistItemList(id: id)
            await send(.onCompleteFetchSelectedChecklistItems(.success(checkboxes)))
          } catch {
            await send(.onCompleteFetchSelectedChecklistItems(.failure(error)))
          }
        }

      case .isFetchingChanged(let isFetching):
        state.isFetching = isFetching
        return .none

      case .isFetchingChecklistItemsChanged(let isFetching):
        state.isFetchingChecklistItems = isFetching
        return .none

      case .onAppendNewChecklist(let checklist):
        state.cards.append(.init(checklist: checklist))
        return .none

      case .updateSelectedCardAfterDelay(let index):
        state.displayedCheckBoxes = state.cards[index].fetchDisplayedCheckBoxes()
        return .none

      case .completeCheckBox(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0 == state.selectedCard }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }

        state.cards[selectedCardIndex].checkBoxList[checkBoxIndex].isCompleted.toggle()
        state.cards[selectedCardIndex].calculateProgress()
        state.selectedCard = state.cards[selectedCardIndex]
        state.displayedCheckBoxes[id: checkBox.id]?.isCompleted.toggle()

        let newCompleted = state.cards[selectedCardIndex].checkBoxList[checkBoxIndex].isCompleted
        return .merge(
          .run { send in
            try await self.clock.sleep(for: .seconds(0.5))
            await send(.updateSelectedCardAfterDelay(index: selectedCardIndex))
          }.animation(.easeIn),
          .run { send in
            try await checklistAPIClient.complete(
              checkBox.checklistId,
              checkBox.id,
              newCompleted
            )
          } catch: { error, send in
            debugPrint("Failed to update checkbox completion: \(error.localizedDescription)")
          }
        )

      case .deleteCheckBox(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0 == state.selectedCard }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }

        state.cards[selectedCardIndex].checkBoxList.remove(at: checkBoxIndex)
        state.cards[selectedCardIndex].calculateProgress()

        return .send(.selectChecklist(card: state.cards[selectedCardIndex]))

      case .onCompleteCheckBox(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))

      case .onDeleteCheckBox(let checkBox):
        return .send(.deleteCheckBox(checkBox: checkBox))

      case .onCompleteDeleteCard(let result):
        switch result {
        case .success(let card):
          state.cards.remove(card)
          return .send(.selectChecklist(card: state.cards.first))

        case .failure(let error):
          debugPrint("onComplteDeleteCard failed: ", error.localizedDescription)
          return .none
        }

      case .onDeleteCard(let card):
        return .run { send in
          do {
            try await checklistAPIClient.deleteProject(checklistId: card.id)
            await send(.onCompleteDeleteCard(.success(card)))
          } catch {
            await send(.onCompleteDeleteCard(.failure(error)))
          }
        }

      case .onCompleteFetchSelectedChecklistItems(let result):
        switch result {
        case .success(let checkBoxes):
          if let selected = state.selectedCard, let idx = state.cards.firstIndex(of: selected) {
            state.cards[idx].checkBoxList = checkBoxes
            state.cards[idx].calculateProgress()
            state.selectedCard = state.cards[idx]
            state.displayedCheckBoxes = state.cards[idx].fetchDisplayedCheckBoxes()
          }

        case .failure(let error):
          debugPrint("onCompleteFetchSelectedChecklistItems failed:", error.localizedDescription)
        }

        return .send(.isFetchingChecklistItemsChanged(isFetching: false))

      default:
        return .none
      }
    }
  }
}

fileprivate extension MainChecklistsStatus {
  var toCard: Card {
    return .init(
      id: id,
      title: title,
      totalItems: totalItems,
      completedItems: completedItems,
      progress: .init(progress),
      checkBoxList: []
    )
  }
}

fileprivate extension Card {
  func fetchDisplayedCheckBoxes() -> IdentifiedArrayOf<CheckBox> {
    return .init(
      uniqueElements: checkBoxList
        .filter { !$0.isCompleted }
        .prefix(3)
    )
  }
}
