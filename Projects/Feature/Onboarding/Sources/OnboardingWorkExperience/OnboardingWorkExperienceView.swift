//
//  OnboardingWorkExperienceView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct OnboardingWorkExperienceView: View {
  @State private var workExperience: String = ""
  @State private var errorText: String?
  @State private var isValid: Bool = false
  
  @FocusState private var focusState
  
  var options = (0..<10).map { "\($0) 년차" }
  @State private var selectionOption = 0
  
  public var body: some View {
    VStack(spacing: .zero) {
      TopNavigation(
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
      
//      InputField(
//        errorMessage: $errorText,
//        text: $workExperience,
//        placeHolder: "0 년차",
//        isFocused: $focusState
//      )
//      .frame(width: 289)
//      .padding(.top, 86)
//      .onChange(of: workExperience) { _, newValue in
//        isValid = !newValue.isEmpty
//        newValue
//      }
      
      
      Picker("Select Choice", selection: $selectionOption) {
        ForEach(0 ..< options.count) {
          Text(options[$0])
        }
      }
      .pickerStyle(.wheel)
      
      Spacer()
      
      CommonButton(
        title: "다음",
        style: .default,
        isActive: isValid,
        action: {
          
        }
      )
      .padding(.horizontal, 15)
      .padding(.bottom, 50)
    }
  }
}
