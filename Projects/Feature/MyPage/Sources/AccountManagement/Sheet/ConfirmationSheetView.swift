//
//  ConfirmationSheetView.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 1/18/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct ConfirmationSheetView: View {
  private let store: StoreOf<ConfirmationSheetStore>
  
  init(store: StoreOf<ConfirmationSheetStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      TopNavigation(
        centerTitle: "",
        trailingItem: (Image.closeCross, {
          store.send(.didTapCloseButton)
        })
      )
      
      Group {
        store.image
          .resizable()
          .scaledToFit()
          .frame(width: 42, height: 42)
        
        titleText
          .padding(.top, 16)
        
        VStack(spacing: 10) {
          confirmButton
          cancelButton
        }
        .padding(.top, 30)
        .padding(.bottom, 20)
      }
      .padding(.horizontal, 15)
    }
  }
  
  private var titleText: some View {
    Text(store.title)
      .notoSans(.headline)
      .foregroundStyle(.greyScale950)
  }
  
  private var cancelButton: some View {
    Button(action: {
      store.send(.didTapCancelButton)
    }) {
      Text(store.cancelButtonTitle)
        .notoSans(.subhead_3)
        .foregroundStyle(.greyScale400)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(.greyScale0)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.greyScale200, lineWidth: 1)
        )
    }
  }
  
  private var confirmButton: some View {
    Button(action: {
      store.send(.didTapConfirmButton)
    }) {
      Text(store.confirmButtonTitle)
        .notoSans(.subhead_3)
        .foregroundStyle(.greyScale0)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(.primary600)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
}
