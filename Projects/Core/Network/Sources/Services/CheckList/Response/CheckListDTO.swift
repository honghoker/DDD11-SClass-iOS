//
//  CheckListDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//


import Foundation

import CoreDomain

public struct CheckListDTO: Decodable {
  let checklistId: String
  let checkboxes: [CheckListItemDTO]
}

extension CheckListDTO {
  var toEntity: CheckList {
    .init(
      id: self.checklistId,
      checkBoxList: self.checkboxes.map { $0.toEntity }
    )
  }
}
