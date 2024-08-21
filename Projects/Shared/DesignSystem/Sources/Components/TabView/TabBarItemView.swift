//
//  TabBarItemView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/15/24.
//

import Foundation
import SwiftUI

public struct TabBarItemView: View {
  private var onTap: (() -> ())?
  
  private let image: Image
  private let title: String
  private let isSelected: Bool
  
  public init(
    image: Image,
    title: String,
    isSelected: Bool
  ) {
    self.image = image
    self.title = title
    self.isSelected = isSelected
  }
  
  public var body: some View {
    Button(action: {
      onTap?()
    }) {
      VStack(alignment: .center, spacing: 4) {
        image
          .renderingMode(.template)
          .frame(width: 24, height: 24)

        Text(title)
          .notoSans(isSelected ? .nav_title_active : .nav_title_inactive)
      }
      .foregroundStyle(isSelected ? .primary700 : .greyScale700)
      .frame(width: 48, height: 44)
      .padding(.top, 20)
    }
  }
  
  public func onTap(_ completion: @escaping () -> ()) -> Self {
    var copy = self
    copy.onTap = completion
    return copy
  }
}
