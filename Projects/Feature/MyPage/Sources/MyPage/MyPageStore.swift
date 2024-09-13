//
//  MyPageStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 9/12/24.
//

import Foundation

import CoreCommon
import CoreDomain

import ComposableArchitecture

@Reducer
public struct MyPageStore {
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    var nickname: String = ""
    var documents: [LegalDocument] = [.privacyPolicy, .termsOfService]
    
    public init() {}
  }
  
  public enum Action {
    case onAppear
    case didTapDocument(LegalDocument)
    case navigateToLegalDocumentPage(document: LegalDocument)
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.nickname = state.userInfo?.nickName ?? ""
        return .none
      case .didTapDocument(let document):
        return .send(.navigateToLegalDocumentPage(document: document))
      default:
        return .none
      }
    }
  }
}
