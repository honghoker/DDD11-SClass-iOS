//
//  Card.swift
//  FeatureHome
//
//  Created by 홍은표 on 9/24/24.
//

import Foundation

import CoreDomain

public struct Card: Identifiable, Hashable, Equatable {
  public let id: String
  public let title: String
  private var totalItems: Int
  private var completedItems: Int
  public var progress: CGFloat
  public var checkBoxList: [CheckBox]

  public init(
    id: String,
    title: String?,
    totalItems: Int,
    completedItems: Int,
    progress: CGFloat,
    checkBoxList: [CheckBox]
  ) {
    self.id = id
    self.title = title ?? ""
    self.totalItems = totalItems
    self.completedItems = completedItems
    self.progress = progress
    self.checkBoxList = checkBoxList
  }

  public init(checklist: Checklist) {
    id = checklist.id
    title = checklist.title ?? ""
    totalItems = checklist.checkBoxList.count
    completedItems = 0
    progress = 0
    checkBoxList = checklist.checkBoxList
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
  
  mutating public func calculateProgress() {
    let total = CGFloat(checkBoxList.count)
    let completed = CGFloat(checkBoxList.filter(\.isCompleted).count)
    let progress = total > 0 ? completed / total : 0
    self.progress = progress
  }
}
