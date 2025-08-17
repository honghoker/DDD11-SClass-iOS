//
//  MainChecklistsStatus.swift
//  CoreDomain
//
//  Created by eunpyo on 8/9/25.
//

import Foundation

public struct MainChecklistsStatus {
  public let id: String
  public let title: String
  public let totalItems: Int
  public let completedItems: Int
  public let progress: Double

  public init(
    id: String,
    title: String,
    totalItems: Int,
    completedItems: Int,
    progress: Double
  ) {
    self.id = id
    self.title = title
    self.totalItems = totalItems
    self.completedItems = completedItems
    self.progress = progress
  }
}
