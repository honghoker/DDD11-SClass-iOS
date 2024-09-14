//
//  CheckList.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct CheckList: Decodable, Equatable {
  public let id: String
  public var checkBoxList: [CheckBox]
  
  public init(id: String, checkBoxList: [CheckBox]) {
    self.id = id
    self.checkBoxList = checkBoxList
  }
}
