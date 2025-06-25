//
//  ArticleSearchRequestDTO.swift
//  CoreNetwork
//
//  Created by eunpyo on 6/7/25.
//

import Foundation

public struct ArticleSearchRequestDTO: Encodable {
  let categoryId: Int?
  let subcategoryId: Int?
  let title: String?
  let sortBy: String?

  init(
    categoryId: Int?,
    subcategoryId: Int?,
    title: String?,
    sortBy: String?
  ) {
    self.categoryId = categoryId
    self.subcategoryId = subcategoryId
    self.title = title
    self.sortBy = sortBy
  }
}
