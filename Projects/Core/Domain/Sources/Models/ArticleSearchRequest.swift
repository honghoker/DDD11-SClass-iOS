//
//  ArticleSearchRequest.swift
//  CoreDomain
//
//  Created by eunpyo on 6/7/25.
//

import Foundation

public struct ArticleSearchRequest {
  public let category: ArticleCategory?
  public let subcategory: ArticleSubcategory?
  public let title: String?
  public let sortBy: ArticleSortType?

  public init(
    category: ArticleCategory?,
    subcategory: ArticleSubcategory?,
    sortBy: ArticleSortType?
  ) {
    self.category = category
    self.subcategory = subcategory
    self.title = nil
    self.sortBy = sortBy
  }

  public init(title: String?) {
    self.category = nil
    self.subcategory = nil
    self.title = title
    self.sortBy = nil
  }
}
