//
//  CreateSessionResponseDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation
import CoreDomain

public struct CreateSessionResponseDTO: Decodable {
  let id: String
  let createdAt: String

  
  public init(id: String, createdAt: String) {
    self.id = id
    self.createdAt = createdAt
  }
  
}
extension CreateSessionResponseDTO {
  var toEntity: ChatSession {
    .init(
      sessionId: self.id,
      createdAt: self.createdAt,
      messages: []
    )
  }
}
