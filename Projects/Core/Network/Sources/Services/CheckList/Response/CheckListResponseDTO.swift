//
//  CheckListDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

public struct CheckListResponseDTO: Decodable {
  let title: String?
  let checklistId: String
  let checkboxes: [CheckListItemDTO]
  
  enum CodingKeys: String, CodingKey {
    case title
    case checklistId
    case checkboxes
  }
}

extension CheckListResponseDTO {
  var toEntity: CheckList {
    .init(
      id: self.checklistId,
      title: self.title,
      checkBoxList: self.checkboxes.map { $0.toEntity }
    )
  }
}
