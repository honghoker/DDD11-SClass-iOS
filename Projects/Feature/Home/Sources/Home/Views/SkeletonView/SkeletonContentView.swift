//
//  SkeletonContentView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/25/24.
//

import SwiftUI

import CoreCommon

struct SkeletonContentView: View {
  private let width: CGFloat
  
  init(width: CGFloat) {
    self.width = max(0, width - 32)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      SkeletonChecklistListView(width: width)
      SkeletonArticleListView(width: width)
    }
    .padding(.horizontal, 16)
  }
}

private struct SkeletonChecklistListView: View {
  private let width: CGFloat
  
  init(width: CGFloat) {
    self.width = width
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      SkeletonRectangleView(width: 88, height: 24)
        .padding(.vertical, 12)
      
      VStack(alignment: .leading, spacing: 12) {
        ForEach(0..<3) { _ in
          SkeletonRoundedView(width: width, height: 48, radius: 4)
        }
      }
    }
  }
}

private struct SkeletonArticleListView: View {
  private let contentMaxWidth: CGFloat
  private let dividerWidth: CGFloat
  
  init(width: CGFloat) {
    self.contentMaxWidth = max(0, width - 104)
    self.dividerWidth = max(0, width - 100)
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      SkeletonRectangleView(width: 88, height: 24)
        .padding(.vertical, 12)
      
      ForEach(0..<3) { _ in
        VStack(alignment: .leading, spacing: 12) {
          HStack(alignment: .top, spacing: 18) {
            VStack(alignment: .leading, spacing: 8) {
              VStack(alignment: .leading, spacing: 4) {
                SkeletonRectangleView(width: 70, height: 18)
                SkeletonRoundedView(width: contentMaxWidth, height: 48, radius: 4)
              }
              SkeletonRectangleView(width: 118, height: 18)
            }
            SkeletonRoundedView(width: 86, height: 86, radius: 4)
          }
          SkeletonRectangleView(width: dividerWidth, height: 0.5)
        }
      }
    }
  }
}
