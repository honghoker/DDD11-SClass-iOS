//
//  ChatSession.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct ChatSession: Equatable {
  public let sessionId: String
  public let createdAt: String
  public var messages: [Message]
  
  public init(sessionId: String, createdAt: String, messages: [Message]) {
    self.sessionId = sessionId
    self.createdAt = createdAt
    self.messages = messages
  }
}
