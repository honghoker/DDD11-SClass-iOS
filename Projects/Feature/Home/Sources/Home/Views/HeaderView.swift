//
//  HomeHeaderView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/22/24.
//

import SwiftUI

import ComposableArchitecture

struct HeaderView: View {
  @Bindable private var store: StoreOf<HomeStore>
  
  init(store: StoreOf<HomeStore>) {
    self.store = store
  }
  
  var body: some View {
    Group {
      if store.isLoading {
        SkeletonHeaderView()
      } else if store.cards.isEmpty {
        emptyView
      } else {
        folderList
      }
    }
    .padding(.top, 28)
  }
  
  private var emptyView: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("나의 업무 폴더")
        .notoSans(.display_2)
        .foregroundStyle(.white)
      
      Button(action: {
        store.send(.didTapAppendFolderButton)
      }) {
        VStack(spacing: 4) {
          Image.appendFolder
            .resizable()
            .scaledToFit()
            .frame(width: 33, height: 33)
          
          VStack(spacing: .zero) {
            Text("폴더 추가하기")
              .notoSans(.subhead_3)
              .foregroundStyle(.primary600)
            
            Text("채팅을 통해 업무 폴더를 생성해보세요")
              .notoSans(.body_1)
              .foregroundStyle(.greyScale400)
          }
        }
      }
      .frame(maxWidth: .infinity)
      .frame(height: 162)
      .background(.greyScale050)
      .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    .padding(.horizontal, 16)
  }
  
  private var folderList: some View {
    VStack(alignment: .leading, spacing: 16) {
      Button(action: {
        // TODO: 프로젝트 관리 페이지 이동
      }) {
        HStack(spacing: 4) {
          Text("나의 업무 폴더")
            .notoSans(.display_2)
            .foregroundStyle(.white)
          
          Image.right
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.white)
        }
      }
      .padding(.horizontal, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(store.cards) { card in
            HomeCardView(
              title: card.title,
              isSelected: store.selectedCard == card,
              progress: card.percent,
              onTap: {
                store.send(.didTapProjectFolder(card: card))
              }
            )
          }
        }
        .padding(.horizontal, 16)
      }
    }
  }
}
