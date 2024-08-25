//
//  OnboardingJobView.swift
//  FeatureOnboarding
//
//  Created by 홍은표 on 8/25/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct OnboardingJobView: View {
  enum JobType: CaseIterable, Identifiable {
    case designer
    case developer
    case planner
    
    var id: Self {
      return self
    }
    
    var name: String {
      switch self {
      case .designer:
        return "디자이너"
      case .developer:
        return "개발자"
      case .planner:
        return "기획자"
      }
    }
  }
  
  @State private var selectedJob: JobType?
  @State private var isValid: Bool = false
  
  public var body: some View {
    VStack(spacing: .zero) {
      TopNavigation(
        centerTitle: "나만의 AI 만들기"
      )
      
      CommonProgressBar(progress: 0.667)
      
      VStack(spacing: 8) {
        Text("나의 직무를 선택해주세요")
          .notoSans(.display_1)
          .foregroundStyle(.black)
        
        Text("새로운 체크리스트와 추천 아티클을 위해 활용돼요.")
          .notoSans(.body_1)
          .foregroundStyle(.greyScale500)
      }
      .padding(.top, 81)
      
      HStack(spacing: 10) {
        ForEach(JobType.allCases) { job in
          Chip(
            title: job.name,
            style: job == selectedJob ? .blue : .default,
            onTap: {
              if !isValid { isValid = true }
              selectedJob = job
            }
          )
        }
      }
      .padding(.top, 30)
      
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
