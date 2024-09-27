//
//  ChecklistDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

public struct ChecklistResponseDTO: Decodable {
  let title: String?
  let checklistId: String
  let checkboxes: [ChecklistItemDTO]
  
  enum CodingKeys: String, CodingKey {
    case title
    case checklistId
    case checkboxes
  }
}

extension ChecklistResponseDTO {
  var toEntity: Checklist {
    .init(
      id: self.checklistId,
      title: self.title,
      checkBoxList: self.checkboxes.map { $0.toEntity }
    )
  }
}
