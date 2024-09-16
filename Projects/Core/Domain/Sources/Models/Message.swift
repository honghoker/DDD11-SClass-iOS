//
//  Message.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct Message: Equatable {
  public let text: String
  public let isUser: Bool
  public let timeStamp: String
  
  public init(text: String, isUser: Bool, timeStamp: String) {
    self.text = text
    self.isUser = isUser
    self.timeStamp = timeStamp
  }
}
