//
//  ThumbnailImage.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/14/24.
//

import SwiftUI

import SharedThirdPartyLib

import Kingfisher

struct ThumbnailImage: View {
  private let urlString: String?
  
  init(urlString: String?) {
    self.urlString = urlString
  }
  
  var body: some View {
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
