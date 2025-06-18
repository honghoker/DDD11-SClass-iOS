//
//  Checklist.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct Checklist: Equatable {
  public let id: String
  public var title: String?
  public let createdAt: String
  public let updatedAt: String
  public var checkBoxList: [CheckBox]
  
  public init(id: String, title: String?, createdAt: String, updatedAt: String, checkBoxList: [CheckBox]) {
    self.id = id
    self.title = title
    self.createdAt = createdAt
    self.updatedAt = updatedAt
    self.checkBoxList = checkBoxList
  }
  
  public init(id: String) {
    self.init(
      id: id,
      title: nil,
      createdAt: "",
      updatedAt: "",
      checkBoxList: []
    )
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}

public extension Checklist {
  static let mock1 = Self(
    id: UUID().uuidString,
    title: "디자인 시스템",
    createdAt: "2025-06-16T07:17:52.859909",
    updatedAt: "2025-06-16T07:17:52.859909",
    checkBoxList: [
      .mock1,
      .mock2,
      .mock3,
      .mock4
    ]
  )
  
  static let mock2 = Self(
    id: UUID().uuidString,
    title: "외주/거래처 협업",
    createdAt: "2025-06-16T07:17:52.859909",
    updatedAt: "2025-06-16T07:17:52.859909",
    checkBoxList: [
      .mock5,
      .mock6,
      .mock7,
      .mock8
    ]
  )
}
