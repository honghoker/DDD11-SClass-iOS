//
//  HomeCardView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/25/24.
//

import SwiftUI

struct HomeCardView: View {
  private let title: String
  private let isSelected: Bool
  private let progress: CGFloat
  private let onTap: () -> Void
  
  init(
    title: String,
    isSelected: Bool,
    progress: CGFloat,
    onTap: @escaping () -> Void
  ) {
    self.title = title
    self.isSelected = isSelected
    self.progress = progress
    self.onTap = onTap
  }
  
  var body: some View {
    Button(action: {
      onTap()
    }) {
      HStack(spacing: .zero) {
        VStack(alignment: .leading, spacing: 10) {
          ProgressView(isSelected: isSelected, progress: progress)
            .padding(.top, 14)
          
          Text(title)
            .notoSans(.subhead_3)
            .foregroundStyle(isSelected ? .primary800 : .greyScale600)
        }
        Spacer()
      }
    }
    .padding(.horizontal, 12)
    .frame(width: 162, height: 120)
    .background(isSelected ? .primary100 : .greyScale050)
    .clipShape(
      .rect(cornerRadius: 10)
    )
  }
}
