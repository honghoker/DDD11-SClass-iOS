//
//  ThumbnailImage.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 6/16/25.
//

import SwiftUI

import SharedThirdPartyLib

import Kingfisher

public struct ThumbnailImage: View {
  private let urlString: String?
  
  public init(urlString: String?) {
    self.urlString = urlString
  }
  
  public var body: some View {
    Group {
      if let urlString, let url = URL(string: urlString) {
        KFImage(url)
          .appendProcessor(DownsamplingImageProcessor(size: .init(width: 86, height: 86)))
          .scaleFactor(UIScreen.main.scale)
          .cacheOriginalImage()
          .roundCorner(radius: .point(3.92), roundingCorners: .all)
          .cancelOnDisappear(true)
          .resizable()
          .scaledToFill()
      }
    }
    .frame(width: 86, height: 86)
    .clipShape(RoundedRectangle(cornerRadius: 3.92))
  }
}
