//
//  Images.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/15/24.
//

import SwiftUI

fileprivate typealias ImageAsset = SharedDesignSystemAsset.Image

public extension Image {
  static let home: Self = ImageAsset.home.swiftUIImage
  static let article: Self = ImageAsset.article.swiftUIImage
  static let chat: Self = ImageAsset.chat.swiftUIImage
  static let history: Self = ImageAsset.history.swiftUIImage
  static let myPage: Self = ImageAsset.myPage.swiftUIImage
  static let rotateLeft: Self = ImageAsset.rotateLeft.swiftUIImage
  static let closeCross: Self = ImageAsset.closeCross.swiftUIImage
  static let externalLink: Self = ImageAsset.externalLink.swiftUIImage
  static let lock: Self = ImageAsset.lock.swiftUIImage
}
