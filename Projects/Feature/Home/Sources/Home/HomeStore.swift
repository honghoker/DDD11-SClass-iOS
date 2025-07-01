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

    var isLoading: Bool = true

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

    case didTapAppendFolderButton
    case didTapArticle(MainArticle)
    case didTapArticleExitButton
    case didTapProjectFolder(card: Card)
    case didTapChecklistCompleteButton(checkBox: CheckBox)
    case didTapNavigateToDetailChecklist(card: Card)

    // MARK: - Internal Actions

    case setChecklistCards([Checklist])
    case setArticles([MainArticle])
    case setSelectedCard(card: Card?)
    case isLoadingChanged(isLoading: Bool)
    case onAppendChecklist(checklist: Checklist)
    case updateSelectedCardAfterDelay(index: Int)
    case completeCheckBox(checkBox: CheckBox)
    case deleteCheckBox(checkBox: CheckBox)
    case onCompleteDeleteCard(Result<Card, Error>)

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

        return .run { send in
          await send(.isLoadingChanged(isLoading: true))

          do {
            async let checklistsResponse = try checklistAPIClient.getChecklists()
            async let articlesResponse = try homeAPIClient.fetchArticles()

            let (checklists, articles) = try await (checklistsResponse, articlesResponse)

            let checklistsWithItems = try await withThrowingTaskGroup(
              of: Checklist.self,
              returning: [Checklist].self
            ) { group in
              for checklist in checklists {
                group.addTask {
                  do {
                    let checkBoxList = try await self.checklistAPIClient.getChecklistItemList(id: checklist.id)
                    var updatedChecklist = checklist
                    updatedChecklist.checkBoxList = checkBoxList
                    return updatedChecklist
                  } catch {
                    debugPrint("Failed to load checklist items for \(checklist.id): \(error)")
                    return checklist
                  }
                }
              }

              var resultDict: [String: Checklist] = [:]
              for try await checklist in group {
                resultDict[checklist.id] = checklist
              }
              return checklists.compactMap { resultDict[$0.id] }
            }

            await send(.setChecklistCards(checklistsWithItems))
            await send(.setArticles(articles))
          } catch {
            debugPrint("HomeStore onAppear failed: \(error.localizedDescription)")
          }

          await send(.isLoadingChanged(isLoading: false))
        }

      case .didTapAppendFolderButton:
        return .send(.onPresentChat)

      case .didTapProjectFolder(let card):
        state.selectedCard = card
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        return .none

      case .didTapChecklistCompleteButton(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))

      case .didTapArticle(let article):
        state.selectedArticle = article
        return .none

      case .didTapArticleExitButton:
        state.selectedArticle = .none
        return .none

      case .didTapNavigateToDetailChecklist(let card):
        return .send(.onNaviagteToDetailChecklist(card: card))

      case .setChecklistCards(let checklists):
        let cards: [Card] = checklists.map {
          .init(id: $0.id, title: $0.title, checkBoxList: $0.checkBoxList)
        }
        state.cards = .init(uniqueElements: cards)

        guard let firstCard = state.cards.first else {
          return .none
        }

        // 첫 번째 카드를 선택된 카드로 설정
        return .send(.setSelectedCard(card: firstCard))

      case .setArticles(let articles):
        state.articles = .init(uniqueElements: Array(articles.prefix(3)))
        return .none

      case .setSelectedCard(let card):
        state.selectedCard = card
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: card)
        return .none

      case .isLoadingChanged(let isLoading):
        state.isLoading = isLoading
        return .none

      case .onAppendChecklist(let checklist):
        let card = Card(
          id: checklist.id,
          title: checklist.title,
          checkBoxList: checklist.checkBoxList
        )

        state.cards.append(card)
        return .none

      case .updateSelectedCardAfterDelay(let index):
        state.displayedCheckBoxes = calculateDisplayedCheckBoxes(for: state.cards[index])
        return .none

      case .completeCheckBox(let checkBox):
        guard
          let selectedCardIndex = state.cards.firstIndex(where: { $0 == state.selectedCard }),
          let checkBoxIndex = state.cards[selectedCardIndex].checkBoxList.firstIndex(of: checkBox)
        else {
          return .none
        }
        
        state.cards[selectedCardIndex].checkBoxList[checkBoxIndex].isCompleted.toggle()
        state.cards[selectedCardIndex].calculatePercent()
        state.selectedCard = state.cards[selectedCardIndex]
        state.displayedCheckBoxes[id: checkBox.id]?.isCompleted.toggle()
        
        return .merge(
          .run { send in
            try await self.clock.sleep(for: .seconds(0.5))
            await send(.updateSelectedCardAfterDelay(index: selectedCardIndex))
          }.animation(.easeIn),
          .run { send in
            try await checklistAPIClient.complete(
              checkBox.checklistId,
              checkBox.id,
              checkBox.isCompleted
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
        state.cards[selectedCardIndex].calculatePercent()

        return .send(.setSelectedCard(card: state.cards[selectedCardIndex]))

      case .onCompleteCheckBox(let checkBox):
        return .send(.completeCheckBox(checkBox: checkBox))

      case .onDeleteCheckBox(let checkBox):
        return .send(.deleteCheckBox(checkBox: checkBox))

      case .onCompleteDeleteCard(let result):
        switch result {
        case .success(let card):
          state.cards.remove(card)
          return .send(.setSelectedCard(card: state.cards.first))

        case .failure(let error):
          debugPrint(error.localizedDescription)
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

      default:
        return .none
      }
    }
  }
}

extension HomeStore {
  private func calculateDisplayedCheckBoxes(for card: Card?) -> IdentifiedArrayOf<CheckBox> {
    guard let checkBoxList = card?.checkBoxList else {
      return .init()
    }

    return .init(uniqueElements: checkBoxList
      .filter { !$0.isCompleted }
      .prefix(3)
    )
  }
}
