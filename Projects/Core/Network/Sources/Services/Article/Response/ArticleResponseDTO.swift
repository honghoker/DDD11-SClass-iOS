//
//  ArticleResponseDTO.swift
//  CoreNetwork
//
//  Created by eunpyo on 4/4/25.
//

import Foundation

import CoreDomain

typealias ArticlesResponseDTO = [ArticleResponseDTO]

public struct ArticleResponseDTO: Decodable {
  public let id: Int
  public let categoryId: Int?
  public let subcategoryId: Int?
  public let postDate: String
  public let source: String
  public let title: String
  public let summary: String
  public let views: Int
  public let thumbnail: String
  public let url: String
  public let hashtags: [String]
}

extension ArticleResponseDTO {
  var toEntity: Article {
    .init(
      id: id,
      categoryId: categoryId,
      subcategoryId: subcategoryId,
      postDate: ISO8601DateFormatter().date(from: postDate) ?? Date(),
      source: source,
      title: title,
      summary: summary,
      views: views,
      thumbnail: thumbnail,
      url: url,
      hashtags: hashtags
    )
  }
}
