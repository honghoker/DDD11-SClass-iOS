//
//  SkeletonRectangleView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/25/24.
//

import SwiftUI

import SkeletonUI

public struct SkeletonRectangleView: View {
  private let width: CGFloat
  private let height: CGFloat
  
  public init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }
  
  public var body: some View {
    Rectangle()
      .skeleton(
        with: true,
        size: .init(width: width, height: height),
        shape: .rectangle
      )
  }
}
