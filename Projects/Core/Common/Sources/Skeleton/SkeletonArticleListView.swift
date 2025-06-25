//
//  SkeletonArticleListView.swift
//  CoreCommon
//
//  Created by eunpyo on 6/8/25.
//

import SwiftUI

public struct SkeletonArticleListView: View {
  private let width: CGFloat

  public init(width: CGFloat) {
    self.width = max(0, width - 32)
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(0..<3) { _ in
        ArticleSearchResultsSkeletonView(width: width)
      }
    }
  }
}

fileprivate struct ArticleSearchResultsSkeletonView: View {
  private let width: CGFloat

  init(width: CGFloat) {
    self.width = width
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      SkeletonRectangleView(width: width, height: 208)
        .clipShape(.rect(cornerRadius: 16))

      VStack(alignment: .leading, spacing: 6) {
        SkeletonRectangleView(width: width * 0.35, height: 20)

        VStack(alignment: .leading, spacing: 2) {
          SkeletonRectangleView(width: width * 0.8, height: 24)
          SkeletonRectangleView(width: width * 0.6, height: 24)
        }

        SkeletonRectangleView(width: width * 0.2, height: 24)
      }
    }
  }
}
