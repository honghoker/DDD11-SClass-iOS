//
//  MyPageCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

public struct MyPageCellView: View {
  private let title: String
  
  public init(title: String) {
    self.title = title
  }
  
  public var body: some View {
    HStack(spacing: 4) {
      Text(title)
        .notoSans(.body_2)
        .foregroundStyle(.greyScale950)
        .padding(.vertical, 12)
        .padding(.leading, 16)
      
      Spacer()
      
      Image.right
        .resizable()
        .scaledToFit()
        .frame(width: 18, height: 18)
        .padding(.trailing, 19)
    }
  }
}
