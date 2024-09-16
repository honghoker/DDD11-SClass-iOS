//
//  CheckBox.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation


public struct CheckBox: Equatable, Decodable {
  public let checkListId: String
  public let label: String
  public let isCompleted: Bool
  public let isMain: Bool
  public let createdAt: String
  public let id: String
  
  public init(checkListId: String, label: String, isCompleted: Bool, isMain: Bool, createdAt: String, id: String) {
    self.checkListId = checkListId
    self.label = label
    self.isCompleted = isCompleted
    self.isMain = isMain
    self.createdAt = createdAt
    self.id = id
  }
}
