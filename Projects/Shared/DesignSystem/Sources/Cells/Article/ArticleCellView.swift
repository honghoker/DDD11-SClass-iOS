//
//  ArticleCellView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 9/20/24.
//

import Foundation
import SwiftUI

import SharedUtils

public struct ArticleCellView<Thumbnail: View>: View {
  private let thumbnailImage: Thumbnail
  private let title: String
  private let category: String
  private let platform: String
  private let postDate: String
  private let url: String
  
  public init(
    @ViewBuilder thumbnail: () -> Thumbnail,
    title: String,
    category: String,
    platform: String,
    postDate: String,
    url: String
  ) {
    self.thumbnailImage = thumbnail()
    self.title = title
    self.category = category
    self.platform = platform
    self.postDate = postDate
    self.url = url
  }
  
  public var body: some View {
    Button(action: {
      
    }) {
      VStack(spacing: 12) {
        HStack(alignment: .top, spacing: .zero) {
          VStack(alignment: .leading, spacing: .zero) {
            Text(category)
              .notoSans(.caption)
              .foregroundStyle(.primary700)
              .padding(.bottom, 4)
            
            Text(title)
              .notoSans(.subhead_4)
              .foregroundStyle(.greyScale900)
              .padding(.bottom, 8)
              .lineLimit(2)
              .multilineTextAlignment(.leading)
            
            HStack(alignment: .center, spacing: 6) {
              Text(platform)
                .notoSans(.caption)
                .foregroundStyle(.greyScale400)
              
              Circle()
                .frame(width: 3, height: 3)
                .foregroundStyle(.greyScale900)
              
              Text(postDate)
                .notoSans(.caption)
                .foregroundStyle(.greyScale400)
            }
          }
          .padding(.trailing, 4.88)
          
          Spacer(minLength: 18)
          
          thumbnailImage
        }
        
        GeometryReader { geometry in
          Divider()
            .background(Color(hex: "E1E3E7"))
            .frame(width: max(0, geometry.size.width - 99.12))
        }
        .frame(height: 0.5)
      }
      .padding(.horizontal, 15.94)
    }
  }
}
