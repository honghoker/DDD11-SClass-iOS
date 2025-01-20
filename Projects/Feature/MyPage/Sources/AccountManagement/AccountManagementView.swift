//
//  AccountManagementView.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 1/7/25.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct AccountManagementView: View {
  @Bindable private var store: StoreOf<AccountManagementStore>
  
  public init(store: StoreOf<AccountManagementStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      TopNavigation(
        leadingItem: (
          Image.left,
          { store.send(.didTapBackButton) }
        ),
        centerTitle: "계정관리"
      )
      
      VStack(alignment: .leading, spacing: 4) {
        accountInformation
        logoutButton
        withdrawButton
        Spacer()
      }
      .background(Color(hex: "FAFAFA"))
    }
    .sheet(store: store.scope(state: \.$sheet, action: \.sheet)) {
      ConfirmationSheetView(store: $0)
        .presentationDetents([.height(308)])
        .cornerRadius(20)
    }
  }
  
  private var accountInformation: some View {
    HStack {
      Text("SNS 연동계정")
        .notoSans(.body_2)
        .foregroundStyle(.greyScale950)
      
      Spacer()
      
      // TODO: - 연동계정 표시
      Text(store.linkedSocialPlatform)
        .notoSans(.body_2)
        .foregroundStyle(.greyScale500)
    }
    .padding(.leading, 16)
    .padding(.trailing, 14)
    .padding(.vertical, 16)
    .background(.greyScale0)
  }
  
  private var logoutButton: some View {
    Button(action: {
      store.send(.didTapLogoutButton)
    }) {
      HStack {
        Text("로그아웃")
          .notoSans(.body_2)
          .foregroundStyle(.greyScale950)
        
        Spacer()
        
        Image.right
          .resizable()
          .frame(width: 18, height: 18)
      }
      .padding(.leading, 16)
      .padding(.trailing, 19)
      .padding(.vertical, 16)
    }
    .background(.greyScale0)
  }
  
  private var withdrawButton: some View {
    Button(action: {
      store.send(.didTapWithdrawButton)
    }) {
      HStack {
        Text("회원탈퇴")
          .notoSans(.body_2)
          .foregroundStyle(.greyScale950)
        
        Spacer()
        
        Image.right
          .resizable()
          .frame(width: 18, height: 18)
      }
      .padding(.leading, 16)
      .padding(.trailing, 19)
      .padding(.vertical, 16)
    }
    .background(.greyScale0)
  }
}
