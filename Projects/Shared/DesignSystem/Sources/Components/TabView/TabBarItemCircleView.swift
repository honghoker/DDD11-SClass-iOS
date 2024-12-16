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
      VStack(spacing: .zero) {
        image
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
        
        Text("생성")
          .notoSans(.nav_title_inactive)
          .foregroundStyle(.greyScale0)
      }
      .padding(.horizontal, 15)
      .padding(.vertical, 9)
      .background(.primary700)
      .clipShape(Circle())
    }
    .padding(2)
    .background(.greyScale0)
    .clipShape(Circle())
    .shadow(color: .greyScale950.opacity(0.1), radius: 6, x: 0, y: 4)
  }
  
  public func onTap(_ completion: @escaping () -> ()) -> Self {
    var copy = self
    copy.onTap = completion
    return copy
  }
}
