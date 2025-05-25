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
  
  enum CodingKeys: String, CodingKey {
    case title
    case summary
    case thumbnail
    case url
    case views
  }
  
  var toEntity: MainArticle {
    return MainArticle(
      title: title,
      category: "디자인 시스템", // TODO: API 에서 안옴
      source: "채널톡", // TODO: API에서 안옴
      postDate: Date(), // TODO: API에서 안옴
      thumbnailURL: thumbnail,
      url: url
    )
  }
}
