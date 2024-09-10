//
//  LegalDocumentStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 9/10/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture

@Reducer
public struct LegalDocumentStore {
  @ObservableState
  public struct State {
    let document: LegalDocument
    
    public init(document: LegalDocument) {
      self.document = document
    }
  }
  
  public enum Action {
    case didTapBackButton
    case navigateToPreviousPage
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
      default:
        return .none
      }
    }
  }
}
