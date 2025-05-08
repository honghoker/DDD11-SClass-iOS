//
//  ArticleResponseDTO.swift
//  CoreNetwork
//
//  Created by eunpyo on 4/4/25.
//

import Foundation

import CoreDomain

public struct ArticlesResponseDTO: Decodable {
  let articles: [ArticleResponseDTO]
}

public struct ArticleResponseDTO: Decodable {
  public let id: Int
  public let category: ArticleCategoryResponse
  public let subcategory: ArticleSubcategoryResponse
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
      category: .init(rawValue: category.rawValue) ?? .all,
      subcategory: .init(rawValue: subcategory.rawValue) ?? .all,
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
