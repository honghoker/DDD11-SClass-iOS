//
//  CommonProgressBar.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/16/24.
//

import SwiftUI

public struct CommonProgressBar: View {
  
  private let progress: Double
  
  public init(progress: Double) {
    self.progress = progress
  }
  
  public var body: some View {
    ProgressView(value: progress)
      .progressViewStyle(
        LinearProgressViewStyle(tint: .primary500)
      )
      .background(.greyScale300)
      .frame(height: 2.5)
  }
}
