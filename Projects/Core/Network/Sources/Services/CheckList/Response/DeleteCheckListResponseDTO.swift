//
//  DeleteCheckListResponseDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct DeleteCheckListResponseDTO: Decodable {
  let deletedIds: [String]
  let deletedCount: Int
}
