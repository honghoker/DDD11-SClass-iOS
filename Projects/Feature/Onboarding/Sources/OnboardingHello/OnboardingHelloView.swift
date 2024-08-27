//
//  OnboardingHelloView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/28/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct OnboardingHelloView: View {
  @Bindable private var store: StoreOf<OnboardingRootStore>
  
  public init(store: StoreOf<OnboardingRootStore>) {
    self.store = store
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      Text(
     """
     반가워요!
     저는 당신을 위한 AI에요.
     """
      )
      .notoSans(.display_1)
      .foregroundStyle(.black)
      .multilineTextAlignment(.center)
      .padding(.top, 85)
      
      Image.onboardingLogo
        .resizable()
        .scaledToFit()
        .frame(width: 99, height: 124)
        .padding(.top, 48)
      
      Spacer()
      
      CommonButton(
        title: "나만의 AI 만들기",
        style: .default,
        isActive: true,
        action: {
          store.send(.didTapNextButton)
        }
      )
      .padding(.horizontal, 15)
      .padding(.bottom, 50)
    }
  }
}
