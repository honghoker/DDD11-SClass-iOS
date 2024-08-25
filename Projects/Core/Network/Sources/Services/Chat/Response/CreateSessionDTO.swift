//
//  CreateSessionDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation
import CoreDomain

public struct CreateSessionDTO: Decodable {
  let sessionId: String
  let createdAt: String
  let messages: [MessageResponseDTO]

  
  public init(sessionId: String, createdAt: String, messages: [MessageResponseDTO]) {
    self.sessionId = sessionId
    self.createdAt = createdAt
    self.messages = messages
  }
  enum CodingKeys : String, CodingKey{
    case sessionId = "session_id"
    case createdAt = "created_at"
    case messages
 }
  
}
extension CreateSessionDTO {
  var toEntity: ChatSession {
    .init(
      sessionId: self.sessionId,
      createdAt: self.createdAt,
      messages: self.messages.map { $0.toEntity }
    )
  }
}
