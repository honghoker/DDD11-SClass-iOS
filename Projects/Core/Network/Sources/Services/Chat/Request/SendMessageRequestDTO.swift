//
//  GetMessagesDTO.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct SendMessageRequestDTO: Encodable {
  let message: String
  
  public init(message: String) {
    self.message = message
  }
}
