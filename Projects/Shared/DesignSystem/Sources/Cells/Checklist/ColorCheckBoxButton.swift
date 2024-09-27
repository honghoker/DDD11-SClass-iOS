//
//  ColorCheckBoxButton.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 9/25/24.
//

import Foundation
import SwiftUI

struct ColorCheckBoxButton: View {
  private let isSelected: Bool
  private let action: () -> ()
  
  init(isSelected: Bool, action: @escaping () -> ()) {
    self.isSelected = isSelected
    self.action = action
  }
  
  var body: some View {
    Button(action: {
      action()
    }) {
      Rectangle()
        .if(isSelected) {
          $0
            .frame(width: 24, height: 24)
            .overlay(alignment: .center) {
              Image.check
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(.primary900)
            }
        }
        .if(!isSelected) {
          $0
            .frame(width: 18, height: 18)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .overlay(
              RoundedRectangle(cornerRadius: 2)
                .stroke(.greyScale100, lineWidth: 1)
            )
            .padding(3)
        }
        .foregroundStyle(.clear)
    }
  }
}
