//
//  MainChecklistsStatusResponseDTO.swift
//  CoreNetwork
//
//  Created by eunpyo on 8/9/25.
//

import Foundation

import CoreDomain

struct MainChecklistsStatusResponseDTO: Decodable {
  let checklistId: Int
  let title: String
  let totalItems: Int
  let completedItems: Int
  let progress: Double

  var toEntity: MainChecklistsStatus {
    return .init(
      id: checklistId.description,
      title: title,
      totalItems: totalItems,
      completedItems: completedItems,
      progress: progress / 100
    )
  }
}
