//
//  FetchArticleResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreDomain

public struct MainArticleResponseDTO: Decodable {
  let title: String
  let summary: String
  let thumbnail: String
  let url: String
  let views: Int
  let source: String
  let categoryName: String?
  let postDate: String

  var toEntity: MainArticle {
    return MainArticle(
      title: title,
      category: categoryName ?? "",
      source: source,
      postDate: ISO8601DateFormatter().date(from: postDate) ?? .init(),
      thumbnailURL: thumbnail,
      url: url
    )
  }
}
