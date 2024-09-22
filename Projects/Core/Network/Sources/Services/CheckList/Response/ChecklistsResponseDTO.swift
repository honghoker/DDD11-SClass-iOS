//
//  ChecklistsResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/22/24.
//

import Foundation

import CoreDomain

struct ChecklistsResponseDTO: Decodable {
  let checklists: [CheckListResponseDTO]
  
  enum CodingKeys: String, CodingKey {
    case checklists = "checklists"
  }
}

extension ChecklistsResponseDTO {
  var toEntity: [CheckList] {
    return checklists.map(\.toEntity)
  }
}
