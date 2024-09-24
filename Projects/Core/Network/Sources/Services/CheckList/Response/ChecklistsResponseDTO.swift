//
//  ChecklistsResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/22/24.
//

import Foundation

import CoreDomain

struct ChecklistsResponseDTO: Decodable {
  let checklists: [ChecklistResponseDTO]
  
  enum CodingKeys: String, CodingKey {
    case checklists = "checklists"
  }
}

extension ChecklistsResponseDTO {
  var toEntity: [Checklist] {
    return checklists.map(\.toEntity)
  }
}
