//
//  ArticleTopNavigation.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/16/25.
//

import SwiftUI

public struct ArticleTopNavigation: View {
  private let title: String
  private let onTapSearch: () -> Void

  public init(
    title: String,
    onTapSearch: @escaping () -> Void
  ) {
    self.title = title
    self.onTapSearch = onTapSearch
  }

  public var body: some View {
    HStack {
      Spacer()

      Button(action: {
        onTapSearch()
      }) {
        Image.search
          .resizable()
          .scaledToFit()
          .frame(width: 24, height: 24)
      }
    }
    .overlay(alignment: .center) {
      Text(title)
        .notoSans(.subhead_4)
        .foregroundStyle(.greyScale950)
    }
    .padding(.vertical, 15)
    .padding(.horizontal, 20)
    .overlay(alignment: .bottom) {
      Divider()
        .background(Color.init(hex: "F4F4F4"))
    }
  }
}
