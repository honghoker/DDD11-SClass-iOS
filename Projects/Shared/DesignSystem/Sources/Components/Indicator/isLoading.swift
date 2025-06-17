//
//  isLoading.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 6/11/25.
//

import SwiftUI

public extension View {
  @ViewBuilder
  func isLoading(_ state: Bool) -> some View {
    self
      .disabled(state)
      .overlay {
        if state {
          Color.black.opacity(0.25)
            .ignoresSafeArea()
            .overlay {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
            }
        }
      }
  }
}
