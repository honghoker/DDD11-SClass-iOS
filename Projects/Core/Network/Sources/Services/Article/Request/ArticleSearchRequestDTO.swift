//
//  ArticleSearchRequestDTO.swift
//  CoreNetwork
//
//  Created by eunpyo on 6/7/25.
//

import Foundation

public struct ArticleSearchRequestDTO: Encodable {
  let category: String?
  let subcategory: String?
  let title: String?
  let sortBy: String?

  init(
    category: String?,
    subcategory: String?,
    title: String?,
    sortBy: String?
  ) {
    self.category = category
    self.subcategory = subcategory
    self.title = title
    self.sortBy = sortBy
  }
}
