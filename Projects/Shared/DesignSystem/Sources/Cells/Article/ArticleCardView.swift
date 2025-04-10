//
//  ArticleCardView.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/8/25.
//

import SwiftUI

import SharedUtils

public struct ArticleCardView<ThumbnailContent: View>: View {

  @State private var anchorFrame: CGRect = .zero

  private let thumbnailBuilder: () -> ThumbnailContent
  private let platform: String
  private let postDate: String
  private let title: String
  private let description: String
  private let hashtags: [String]
  private let isPopupOpen: Bool
  private let onOpenPopup: (CGRect) -> Void

  public init(
    @ViewBuilder thumbnailBuilder: @escaping () -> ThumbnailContent,
    platform: String,
    postDate: String,
    title: String,
    description: String,
    hashtags: [String],
    isPopupOpen: Bool,
    onOpenPopup: @escaping (CGRect) -> Void
  ) {
    self.thumbnailBuilder = thumbnailBuilder
    self.platform = platform
    self.postDate = postDate
    self.title = title
    self.description = description
    self.hashtags = hashtags
    self.isPopupOpen = isPopupOpen
    self.onOpenPopup = onOpenPopup
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      thumbnail
      metadata
      content
      footer
    }
    .listRowBackground(Color.clear)
    .listRowSeparator(.hidden)
    .listRowInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
  }

  private var thumbnail: some View {
    thumbnailBuilder()
      .frame(maxWidth: .infinity)
      .frame(height: 208)
      .clipShape(
        .rect(cornerRadius: 14)
      )
  }

  private var metadata: some View {
    HStack(spacing: 6) {
      Text(platform)
        .notoSans(.body_1)
        .foregroundStyle(Color(hex: "66625F"))

      Circle()
        .frame(width: 3, height: 3)
        .foregroundStyle(Color(hex: "66625F"))

      Text(postDate)
        .notoSans(.body_1)
        .foregroundStyle(Color(hex: "66625F"))
    }
    .padding(.top, 12)
  }

  private var content: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text(title)
        .notoSans(.subhead_4)
        .foregroundStyle(.greyScale950)

      Text(description)
        .notoSans(.body_2)
        .foregroundStyle(Color(hex: "999592"))
    }
    .padding(.top, 6)
  }

  private var footer: some View {
    HStack(spacing: .zero) {
      tags
      Spacer()
      menuButton
    }
  }

  private var tags: some View {
    HStack(spacing: 6) {
      ForEach(hashtags, id: \.self) { hashtag in
        Text(hashtag)
          .notoSans(.body_1)
          .foregroundStyle(.greyScale0)
          .padding(.vertical, 2)
          .padding(.horizontal, 6)
          .background(Color(hex: "A3A3A3"))
          .clipShape(.rect(cornerRadius: 4))
      }
    }
  }

  private var menuButton: some View {
    Button(action: {
      onOpenPopup(anchorFrame)
    }) {
      (isPopupOpen ? Image.closeCross : Image.vertical)
        .resizable()
        .scaledToFit()
        .foregroundStyle(Color(hex: isPopupOpen ? "666666" : "A3A3A3"))
        .frame(width: 22, height: 24)
    }
    .buttonStyle(.plain)
    .frame(width: 22, height: 24)
    .onFrameChange {
      anchorFrame = $0
    }
    .padding(.top, 6)
  }
}
