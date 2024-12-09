//
//  ProgressView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/22/24.
//

import SwiftUI

struct ProgressView: View {
  private let progress: CGFloat
  private let isSelected: Bool
  
  init(
    isSelected: Bool,
    progress: CGFloat
  ) {
    self.isSelected = isSelected
    self.progress = progress
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ZStack {
        Circle()
          .stroke(isSelected ? .greyScale0 : .greyScale100, lineWidth: 8)
          .frame(width: 62, height: 62)
        
        Circle()
          .trim(from: 0, to: progress)
          .stroke(isSelected ? .primary800 : .greyScale400, style: StrokeStyle(lineWidth: 8, lineCap: .butt, lineJoin: .bevel))
          .rotationEffect(.degrees(-90))
          .frame(width: 62, height: 62)
      }
      .overlay(alignment: .center) {
        HStack(spacing: .zero) {
          Text("\(Int(progress * 100))")
            .notoSans(.subhead_4)
          Text("%")
            .notoSans(.subhead_2)
        }
        .foregroundStyle(isSelected ? .primary800 : .greyScale400)
      }
    }
  }
}
