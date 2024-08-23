//
//  TopArticleNavigation.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/20/24.
//

import SwiftUI

public struct TopArticleNavigation: View {
  
  @State private var title: String = ""
  private let leftAction: () -> Void
  private let rightAction: () -> Void
  
  public init(
    title: String,
    leftAction: @escaping () -> Void,
    rightAction: @escaping () -> Void
  ) {
    self.title = title
    self.leftAction = leftAction
    self.rightAction = rightAction
  }
  
  public var body: some View {
    HStack {
      navigationItem(
        image: .closeCross,
        leftAction
      )
      
      titleContect()
      
      navigationItem(
        image: .externalLink,
        rightAction
      )
    }
  }
  
  @ViewBuilder
  private func titleContect() -> some View {
    HStack(spacing: 8) {
      Image.lock
        .resizable()
        .scaledToFit()
        .frame(width: 14)
        .foregroundStyle(Color.init(hex: "66625F"))
        .padding(5)
        .background(.white)
        .clipShape(Circle())
      
      TextField(
        "사이트 주소 입력",
        text: $title,
        prompt: Text("사이트 주소 입력")
          .foregroundStyle(Color.init(hex: "A7A7A7"))
      )
      .foregroundStyle(Color.init(hex: "A7A7A7"))
      .notoSans(.body_long_1)
    }
    .padding(.horizontal, 6)
    .padding(.vertical, 4)
    .background(Color.init(hex: "F5F5F5"))
    .clipShape(RoundedRectangle(cornerRadius: 37))
  }
  
  @ViewBuilder
  private func navigationItem(
    image: Image,
    _ action: @escaping () -> Void
  ) -> some View {
    Button(action: {
      action()
    }, label: {
      image
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .foregroundStyle(.greyScale950)
    })
  }
}
