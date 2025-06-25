//
//  ArticleSubNavigationBar.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/30/25.
//

import SwiftUI

public struct ArticleSubNavigationBar: View {
  private let title: String
  private let showOrderButton: Bool
  private let isPresented: Bool
  private let onOpenPopup: (CGRect) -> Void

  public init(
    title: String,
    showOrderButton: Bool,
    isPresented: Bool,
    onOpenPopup: @escaping (CGRect) -> Void
  ) {
    self.title = title
    self.showOrderButton = showOrderButton
    self.isPresented = isPresented
    self.onOpenPopup = onOpenPopup
  }

  public var body: some View {
    HStack {
      Text(title)
        .notoSans(.subhead_4)
        .foregroundStyle(.greyScale950)
        .padding(.vertical, 12)

      Spacer()

      if showOrderButton {
        ArticleOrderButton(isPopupOpen: isPresented, onOpenPopup: onOpenPopup)
      }
    }
  }
}

struct ArticleOrderButton: View {
  @State private var anchorFrame: CGRect = .zero
  private let isPopupOpen: Bool
  private let onOpenPopup: (CGRect) -> Void

  init(
    isPopupOpen: Bool,
    onOpenPopup: @escaping (CGRect) -> Void
  ) {
    self.isPopupOpen = isPopupOpen
    self.onOpenPopup = onOpenPopup
  }

  var body: some View {
    Button(action: {
      onOpenPopup(anchorFrame)
    }) {
      (isPopupOpen ? Image.closeCross : Image.order)
        .resizable()
        .scaledToFit()
        .foregroundStyle(.greyScale950)
        .frame(width: 24, height: 24)
    }
    .buttonStyle(.plain)
    .frame(width: 24, height: 24)
    .onFrameChange {
      anchorFrame = $0
    }
  }
}
