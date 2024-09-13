//
//  LegalDocumentView.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 9/10/24.
//

import Foundation
import SwiftUI

import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

struct LegalDocumentView: View {
  private let store: StoreOf<LegalDocumentStore>
  
  init(store: StoreOf<LegalDocumentStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      TopNavigation(
        leadingItem: (
          .left,
          {
            store.send(.didTapBackButton)
          }
        ),
        centerTitle: store.document.title
      )
      .overlay(alignment: .bottom) {
        Divider()
          .background(Color.init(hex: "F4F4F4"))
      }
      
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          ForEach(store.document.sections) { section in
            LegalDocumentSectionView(section: section)
          }
        }
        .padding(.top, 14)
        .padding(.horizontal, 16)
      }
    }
  }
}

private struct LegalDocumentSectionView: View {
  private let section: LegalDocumentSection
  
  fileprivate init(section: LegalDocumentSection) {
    self.section = section
  }
  
  fileprivate var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text(section.title)
        .notoSans(.body_long_1)
        .foregroundStyle(.greyScale950)
      Text(section.content)
        .notoSans(.body_long_1)
        .foregroundStyle(.greyScale400)
    }
    .padding(.bottom, 16)
  }
}
