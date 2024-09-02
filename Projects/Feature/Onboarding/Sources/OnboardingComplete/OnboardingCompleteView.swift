//
//  OnboardingCompleteView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/30/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

public struct OnboardingCompleteView: View {
  
  @Bindable private var store: StoreOf<OnboardingRootStore>
  
  init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      GradientBackgroundView()
      
      VStack(spacing: .zero) {
        VStack(alignment: .leading, spacing: 20) {
          Image.onboardingAISettingComplete
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
          
          VStack(alignment: .leading, spacing: 16) {
            Text("AI 설정 완료")
              .notoSans(.display_3)
              .foregroundStyle(.white)
            
            Text("내 업무 맞춤형 체크리스트를 만들어보세요.")
              .notoSans(.body_2)
              .foregroundStyle(.white)
          }
          
          Spacer()
          
          CommonButton(
            title: "확인",
            style: .contrast,
            isActive: true,
            action: {
              
            }
          )
          .padding(.horizontal, 15)
          .padding(.bottom, 50)
        }
      }
      .padding(.top, 142)
      .padding(.horizontal, 15)
    }
    .navigationBarBackButtonHidden()
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
