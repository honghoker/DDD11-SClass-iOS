//
//  OnboardingCompleteView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/30/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct OnboardingCompleteView: View {
  @Bindable private var store: StoreOf<OnboardingRootStore>
  
  init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  var body: some View {
    ZStack {
      GradientBackgroundView()
      
      VStack(alignment: .leading, spacing: .zero) {
        VStack(alignment: .leading, spacing: 20) {
          Image.onboardingAISettingComplete
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
          
          VStack(alignment: .leading, spacing: 16) {
            Text(
              """
              매일 성장하고
              더 멋지게 일해보세요.
              """
            )
            .notoSans(.display_3)
            .foregroundStyle(.greyScale0)
            
            Text("이제 신입키트와 함께, 맞춤형 AI로 업무 고민을 쉽게 해결하세요.")
              .notoSans(.body_2)
              .foregroundStyle(.greyScale0)
          }
        }
        .padding(.horizontal, 15)
        
        Spacer()
        
        CommonButton(
          title: "확인",
          style: .contrast,
          isActive: true,
          action: {
            store.send(.didTapCompleteButton)
          }
        )
        .padding(.bottom, 50)
      }
      .padding(.top, 142)
      .padding(.horizontal, 15)
    }
    .ignoresSafeArea()
  }
}

private struct GradientBackgroundView: View {
  fileprivate var body: some View {
    LinearGradient(
      gradient: Gradient(stops: [
        .init(color: Color(hex: "48B7FF"), location: 0.07),
        .init(color: Color(hex: "FFF1C5"), location: 1.0)
      ]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    .edgesIgnoringSafeArea(.all)
  }
}
