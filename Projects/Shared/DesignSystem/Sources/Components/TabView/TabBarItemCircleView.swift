//
//  TabBarItemCircleView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/15/24.
//

import Foundation
import SwiftUI

public struct TabBarItemCircleView: View {
  private var onTap: (() -> ())?
  private let image: Image
  
  public init(image: Image) {
    self.image = image
  }
  
  public var body: some View {
    Button(action: {
      onTap?()
    }) {
      image
        .padding(.top, 10)
        .padding(.bottom, 12)
        .padding(.horizontal, 11)
        .background(.primary700)
    }
    .cornerRadius(23)
  }
  
  public func onTap(_ completion: @escaping () -> ()) -> Self {
    var copy = self
    copy.onTap = completion
    return copy
  }
}
