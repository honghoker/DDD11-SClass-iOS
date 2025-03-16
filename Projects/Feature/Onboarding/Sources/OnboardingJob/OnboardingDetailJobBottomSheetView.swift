//
//  OnboardingDetailJobBottomSheetView.swift
//  FeatureOnboarding
//
//  Created by 현수빈 on 3/16/25.
//

import SwiftUI

import CoreDomain
import SharedDesignSystem

import ComposableArchitecture

struct OnboardingDetailJobBottomSheetView: View {
  @Bindable private var store: StoreOf<OnboardingJobStore>
  
  init(store: StoreOf<OnboardingJobStore>) {
    self.store = store
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      TopNavigation(
        centerTitle: "",
        trailingItem: (.closeCross, {
          store.send(.didTapDismissButton)
        })
      )
      
      HStack(spacing: 8) {
        if let selected = store.selectedCategory {
          Text(selected)
            .notoSans(.headline)
            .foregroundStyle(.greyScale950)
        }
        Spacer()
      }
      .padding(.top, 10)
      .padding(.bottom, 40)
      
      ScrollView {
        VStack(spacing: 20) {
          ForEach(store.detailJobList ,id: \.self) { job in
            cell(entity: job)
          }
        }
        
        Spacer()
      }
      .scrollIndicators(.hidden)
      
      CommonButton(
        title: "선택 완료",
        style: .default,
        isActive: store.isBottomSheetActive,
        action: {
          store.send(.didTpConfirmDetailJobButton)
        }
      )
      .padding(.horizontal, 15)
      .padding(.bottom, 50)
    }
    .padding(.horizontal, 10)
  }
  
  private func cell(entity: JobType) -> some View {
    VStack(spacing: 20) {
      HStack {
        Text(entity.title)
          .notoSans(.body_1)
          .foregroundStyle(.greyScale950)
        
        Spacer()
        
        Button(action: {
          store.send(.didTapDetailJob(entity))
        }) {
          Circle()
            .stroke(Color.greyScale200, lineWidth: 1)
            .frame(width: 24, height: 24)
            .if(store.selectedJob == entity) {
              $0.background(.primary600)
                .clipShape(.circle)
            }
        }
      }
      
      Rectangle()
        .fill(.greyScale200)
        .frame(height: 1)
    }
  }
}

