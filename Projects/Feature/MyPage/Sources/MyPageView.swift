//
//  MyPageView.swift
//  OnboardingKit.
//
//  Created by SClass on 2024/08/09
//  Copyright © 2024 DDD , Ltd., All rights reserved.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct MyPageView: View {
  private let store: StoreOf<MyPageStore>
  
  public init(store: StoreOf<MyPageStore>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStack {
      VStack(spacing: .zero) {
        VStack(alignment: .leading, spacing: 40) {
          Text(
          """
          안녕하세요
          nickname 님
          """
          )
          .notoSans(.display_1)
          .foregroundStyle(.greyScale950)
          
          Divider()
            .foregroundStyle(.black)
        }
        .padding(.top, 53)
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
        
        VStack(spacing: 4) {
          MyPageCellView(
            title: "개인정보처리방침",
            onTap: {
              store.send(.didTapPrivacyPolicy)
            }
          )
          
          MyPageCellView(
            title: "서비스 이용 약관",
            onTap : {
              store.send(.didTapTermsOfService)
            }
          )
        }
        
        Spacer()
      }
    }
  }
}
