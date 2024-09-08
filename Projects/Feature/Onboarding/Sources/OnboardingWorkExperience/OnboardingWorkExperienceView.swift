//
//  OnboardingWorkExperienceView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import SwiftUI

import SharedDesignSystem

import ComposableArchitecture

struct OnboardingWorkExperienceView: View {
  @Bindable private var store: StoreOf<OnboardingWorkExperienceStore>
  
  init(store: StoreOf<OnboardingWorkExperienceStore>) {
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
        centerTitle: "나만의 AI 만들기"
      )
      
      CommonProgressBar(progress: 1)
      
      Text(
        """
        지금 직군에 몇 년차
        경력을 가지고 계신가요?
        """
      )
      .notoSans(.display_1)
      .foregroundStyle(.black)
      .multilineTextAlignment(.center)
      .padding(.top, 81)
      
      Picker("Select Choice", selection: $store.workExperience) {
        ForEach(store.workExperienceList, id: \.self) {
          Text("\($0) 년차")
        }
      }
      .pickerStyle(.wheel)
      .padding(.top, 86)
      
      Spacer()
      
      CommonButton(
        title: "다음",
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
