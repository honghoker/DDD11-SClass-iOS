//
//  SkeletonHeaderView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/25/24.
//

import SwiftUI

import CoreCommon

struct SkeletonHeaderView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      SkeletonRectangleView(width: 198, height: 32)
          
      HStack(spacing: 8) {
        SkeletonRoundedView(width: 162, height: 120, radius: 10)
        SkeletonRoundedView(width: 162, height: 120, radius: 10)
        SkeletonRoundedView(width: 162, height: 120, radius: 10)
      }
    }
    .padding(.horizontal, 16)
  }
}
