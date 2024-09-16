//
//  CreateSessionResponseDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation
import CoreDomain

public struct CreateSessionResponseDTO: Decodable {
  let sessionId: String
  let createdAt: String
  let userId: String
  let messages: [MessageResponseDTO]

  
  public init(sessionId: String, createdAt: String, userId: String, messages: [MessageResponseDTO]) {
    self.sessionId = sessionId
    self.createdAt = createdAt
    self.userId = userId
    self.messages = messages
  }
  
  enum CodingKeys : String, CodingKey{
    case userId = "user_id"
    case sessionId = "session_id"
    case createdAt = "created_at"
    case messages
 }
  
}
extension CreateSessionResponseDTO {
  var toEntity: ChatSession {
    .init(
      sessionId: self.sessionId,
      createdAt: self.createdAt,
      messages: self.messages.map { $0.toEntity }
    )
  }
}
