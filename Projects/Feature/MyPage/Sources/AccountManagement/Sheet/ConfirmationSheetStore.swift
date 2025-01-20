//
//  ConfirmationSheetStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 1/20/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
public struct ConfirmationSheetStore {
  @ObservableState
  public struct State {
    var image: Image
    var title: String
    var confirmButtonTitle: String
    var cancelButtonTitle: String
    
    public init(
      image: Image,
      title: String,
      confirmButtonTitle: String,
      cancelButtonTitle: String
    ) {
      self.image = image
      self.title = title
      self.confirmButtonTitle = confirmButtonTitle
      self.cancelButtonTitle = cancelButtonTitle
    }
  }
  
  public enum Action {
    case didTapCloseButton
    case didTapConfirmButton
    case didTapCancelButton
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapCloseButton:
        return .none
        
      case .didTapConfirmButton:
        return .none
        
      case .didTapCancelButton:
        return .none
      }
    }
  }
}
