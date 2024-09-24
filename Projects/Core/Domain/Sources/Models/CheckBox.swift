//
//  CheckBox.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct CheckBox: Decodable, Identifiable, Equatable {
  public let checklistId: String
  public let label: String
  public var isCompleted: Bool
  public let isMain: Bool
  public let createdAt: String
  public let id: String
  
  public init(
    checkListId: String,
    label: String,
    isCompleted: Bool,
    isMain: Bool,
    createdAt: String,
    id: String
  ) {
    self.checklistId = checkListId
    self.label = label
    self.isCompleted = isCompleted
    self.isMain = isMain
    self.createdAt = createdAt
    self.id = id
  }
  
  enum CodingKeys: String, CodingKey {
    case checklistId
    case label
    case isCompleted
    case isMain
    case createdAt
    case id
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}
