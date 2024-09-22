//
//  CheckList.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct CheckList: Decodable, Equatable {
  public let id: String
  public var title: String?
  public var checkBoxList: [CheckBox]
  
  public init(id: String, title: String?, checkBoxList: [CheckBox]) {
    self.id = id
    self.title = title
    self.checkBoxList = checkBoxList
  }
  
  public init(id: String) {
    self.init(
      id: id,
      title: nil,
      checkBoxList: []
    )
  }
}
