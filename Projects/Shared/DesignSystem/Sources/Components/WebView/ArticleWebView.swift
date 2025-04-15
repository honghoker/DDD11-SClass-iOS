//
//  ArticleWebView.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/16/25.
//

import SwiftUI

public struct ArticleWebView: View {
  private let title: String
  private let url: String
  private let didTapClose: () -> Void

  public init(title: String, url: String, didTapClose: @escaping () -> Void) {
    self.title = title
    self.url = url
    self.didTapClose = didTapClose
  }

  public var body: some View {
    VStack {
      TopArticleNavigation(
        title: title,
        url: url,
        leftAction: {
          didTapClose()
        }
      )
      .padding()

      WebViewRepresentable(url: url)
    }
  }
}
