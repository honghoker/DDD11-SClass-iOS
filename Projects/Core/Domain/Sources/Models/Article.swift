//
//  Article.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

public struct Article: Decodable, Identifiable {
  public let id: String
  public let title: String
  public let category: String
  public let platform: String
  public let postDate: Date
  public let thumbnailURL: String
  public let url: String
  
  public init(
    id: String,
    title: String,
    category: String,
    source: String,
    postDate: Date,
    thumbnailURL: String,
    url: String
  ) {
    self.id = id
    self.title = title
    self.category = category
    self.platform = source
    self.postDate = postDate
    self.thumbnailURL = thumbnailURL
    self.url = url
  }
}
