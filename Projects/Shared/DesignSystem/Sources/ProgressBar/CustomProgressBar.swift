//
//  CustomProgressBar.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/16/24.
//

import SwiftUI

public struct CustomProgressBar: View {
  
  private let progress : Double
  
  public init(progress: Double) {
    self.progress = progress
  }
  
  public var body: some View {
    ProgressView(value: progress)
      .progressViewStyle(
        LinearProgressViewStyle(tint: Color.primary500)
      )
      .background(Color.greyScale300)
      .frame(height: 2.5)
  }
}
