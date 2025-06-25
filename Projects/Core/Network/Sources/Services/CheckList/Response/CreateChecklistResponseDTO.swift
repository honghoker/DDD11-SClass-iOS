//
//  CreateChecklistResponseDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 6/11/25.
//

import Foundation

import CoreDomain

public struct CreateChecklistResponseDTO: Decodable {
  let id: Int
  let userNo: Int
  let title: String
  let createdTime: String
  let updatedTime: String
}

extension CreateChecklistResponseDTO {
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
