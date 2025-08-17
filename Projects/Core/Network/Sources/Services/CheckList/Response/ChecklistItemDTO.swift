//
//  ChecklistItemDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

public struct ChecklistItemDTO: Decodable {
  let id: Int
  let checklistId: Int
  let content: String?
  let completed: Bool
  let createdTime: String
  let updatedTime: String
  
  public init(id: Int, checklistId: Int, content: String, completed: Bool, createdTime: String, updatedTime: String) {
    self.id = id
    self.checklistId = checklistId
    self.content = content
    self.completed = completed
    self.createdTime = createdTime
    self.updatedTime = updatedTime
  }
}


extension ChecklistItemDTO {
  var toEntity: CheckBox {
    .init(
      checklistId: self.checklistId.description,
      label: self.content ?? "",
      isCompleted: self.completed,
      createdAt: self.createdTime,
      id: self.id.description
    )
  }
}
