//
//  ArticleSearchInputView.swift
//  FeatureArticle
//
//  Created by eunpyo on 4/23/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct ArticleSearchInputView: View {
  @Bindable private var store: StoreOf<ArticleSearchInputStore>
  
  public init(store: StoreOf<ArticleSearchInputStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      navigationBar

      if !store.recentSearchTerms.isEmpty {
        recentSearchTermsSection
      }
      
      Spacer()
    }
    .onAppear {
      store.send(.onAppear)
    }
  }

  private var navigationBar: some View {
    HStack(spacing: 5) {
      Button(action: {
        store.send(.didTapBackButton)
      }) {
        Image.left
          .resizable()
          .scaledToFit()
          .foregroundStyle(.greyScale950)
      }
      .frame(width: 24, height: 24)

      searchTextField
    }
    .padding(.vertical, 15)
    .padding(.horizontal, 20)
    .overlay(alignment: .bottom) {
      Divider()
        .background(Color.init(hex: "DDDDDD"))
    }
  }

  private var searchTextField: some View {
    HStack(alignment: .center, spacing: 8) {
      TextField(
        "",
        text: $store.searchTerm,
        prompt: Text("원하는 아티클을 찾아보세요!")
          .foregroundStyle(Color.init(hex: "A7A7A7"))
      )
      .notoSans(.body_2)
      .foregroundStyle(.greyScale900)
      .frame(height: 24)
      .onSubmit {
        store.send(.didSubmit)
      }

      if !store.searchTerm.isEmpty {
        Button(action: {
          store.send(.didTapClearSearchTerm)
        }) {
          Image.diagonalCrossCircle
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
        }
        .frame(width: 24, height: 24)
      }
    }
    .padding(.vertical, 8)
    .padding(.leading, 15)
    .padding(.trailing, 10)
    .background(Color.init(hex: "F5F5F5"))
    .clipShape(.rect(cornerRadius: 100))
  }

  private var recentSearchTermsSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading, spacing: 20) {
        HStack {
          Text("최근 검색어")
            .notoSans(.nav_title_inactive)
            .foregroundStyle(.greyScale500)
          
          Spacer()
        }
        
        LazyVStack {
          ForEach(store.recentSearchTerms, id: \.self) { searchTerm in
            recentSearchTermCell(searchTerm)
          }
        }
      }
      .padding(.horizontal, 16)
      
      VStack(spacing: 12) {
        Rectangle()
          .background(.greyScale950)
          .frame(height: 0.5)
        
        HStack {
          Spacer()
          
          Button(action: {
            store.send(.didTapClearRecentSearchTermButton)
          }) {
            Text("전체 삭제")
              .notoSans(.caption)
              .foregroundStyle(.greyScale950)
          }
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private func recentSearchTermCell(_ searchTerm: String) -> some View {
    HStack(spacing: 8) {
      Text(searchTerm)
        .notoSans(.body_1)
        .foregroundStyle(.greyScale800)
      
      Spacer()
      
      Button {
        store.send(.removeRecentSearchTerm(searchTerm))
      } label: {
        Image.diagonalCross
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
          .foregroundStyle(.greyScale500)
      }
      .buttonStyle(.plain)
    }
    .contentShape(.rect)
    .onTapGesture {
      store.send(.didTapRecentSearchTerm(searchTerm))
    }
  }
}
