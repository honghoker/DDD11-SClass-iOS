//
//  ChecklistDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

public struct ChecklistResponseDTO: Decodable {
  let id: Int
  let userNo: Int
  let title: String?
  let createdTime: String
  let updatedTime: String
  
}

extension ChecklistResponseDTO {
  var toEntity: Checklist {
    .init(
      id: self.id.description,
      title: self.title,
      createdAt: self.createdTime,
      updatedAt: self.updatedTime,
      checkBoxList: []
    )
  }
}
