//
//  ListSection.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/21/24.
//

import SwiftUI

struct ListSection: View {
  private let title: String
  private let onTap: () -> Void
  
  init(
    title: String,
    onTap: @escaping () -> Void
  ) {
    self.title = title
    self.onTap = onTap
  }
  
  var body: some View {
    HStack(spacing: 8) {
      Text(title)
        .notoSans(.subhead_4)
        .foregroundStyle(.black)
      
      Spacer()
      
      Button(action: onTap) {
        Image.right
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      }
    }
    .padding(.vertical, 12)
    .padding(.horizontal, 16)
  }
}
