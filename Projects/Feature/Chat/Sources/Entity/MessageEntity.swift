//
//  MessageEntity.swift
//  FeatureChat
//
//  Created by 현수빈 on 8/30/24.
//

import Foundation
import SharedDesignSystem

public struct MessageEntity: Equatable {
  let title: String
  let content: String
  let type: MessageBubbleType
  
  let checkList: [CheckListEntity]
  
  public init(title: String, content: String, type: MessageBubbleType, checkList: [CheckListEntity] = []) {
    self.title = title
    self.content = content
    self.type = type
    self.checkList = checkList
  }
}
