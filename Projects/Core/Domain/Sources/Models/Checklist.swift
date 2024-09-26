//
//  Checklist.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct Checklist: Decodable, Equatable {
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
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case checkBoxList
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}

public extension Checklist {
  static let mock1 = Self(
    id: UUID().uuidString,
    title: "디자인 시스템",
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
    checkBoxList: [
      .mock5,
      .mock6,
      .mock7,
      .mock8
    ]
  )
}
