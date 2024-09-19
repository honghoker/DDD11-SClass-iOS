//
//  FetchArticleResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

import CoreDomain

public struct ArticleResponseDTO: Decodable {
  let id: String
  let category: String
  let postDate: String
  let source: String
  let title: String
  let thumbnail: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case id = "articleId"
    case category
    case postDate
    case source
    case title
    case thumbnail
    case url
  }
  
  var toEntity: Article {
    return Article(
      id: id,
      title: title,
      category: category,
      source: source,
      postDate: ISO8601DateFormatter().date(from: postDate) ?? Date(),
      thumbnailURL: thumbnail,
      url: url
    )
  }
}
