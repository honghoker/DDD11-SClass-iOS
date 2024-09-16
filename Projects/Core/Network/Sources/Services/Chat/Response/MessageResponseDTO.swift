//
//  MessageResponseDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation
import CoreDomain

public struct MessageResponseDTO: Decodable {
  let messageText: String
  let isUser: Bool
  let timestamp: String
  
  public init(messageText: String, isUser: Bool, timestamp: String) {
    self.messageText = messageText
    self.isUser = isUser
    self.timestamp = timestamp
  }
  
  enum CodingKeys : String, CodingKey{
    case messageText = "message_text"
    case isUser = "is_user"
    case timestamp = "timestamp"
 }
  
}

extension MessageResponseDTO {
  var toEntity: Message {
    .init(
      text: self.messageText,
      isUser: self.isUser,
      timeStamp: self.timestamp
    )
  }
}
