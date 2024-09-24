//
//  SkeletonRoundedView.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/25/24.
//

import SwiftUI

import SkeletonUI

public struct SkeletonRoundedView: View {
  private let width: CGFloat
  private let height: CGFloat
  private let radius: CGFloat
  
  public init(width: CGFloat, height: CGFloat, radius: CGFloat) {
    self.width = width
    self.height = height
    self.radius = radius
  }
  
  public var body: some View {
    Rectangle()
      .skeleton(
        with: true,
        size: .init(width: width, height: height),
        shape: .rounded(.radius(radius))
      )
  }
}
