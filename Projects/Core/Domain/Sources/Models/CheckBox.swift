//
//  CheckBox.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

public struct CheckBox: Decodable, Identifiable, Equatable {
  public let checklistId: String
  public let label: String
  public var isCompleted: Bool
  public let isMain: Bool
  public let createdAt: String
  public let id: String
  
  public init(
    checklistId: String,
    label: String,
    isCompleted: Bool,
    isMain: Bool,
    createdAt: String,
    id: String
  ) {
    self.checklistId = checklistId
    self.label = label
    self.isCompleted = isCompleted
    self.isMain = isMain
    self.createdAt = createdAt
    self.id = id
  }
  
  enum CodingKeys: String, CodingKey {
    case checklistId
    case label
    case isCompleted
    case isMain
    case createdAt
    case id
  }
  
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.id == rhs.id
  }
}

extension CheckBox {
  static let mock1 = Self(
    checklistId: UUID().uuidString,
    label: "협업 도구 활용",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock2 = Self(
    checklistId: UUID().uuidString,
    label: "컴포넌트 요소화 등록",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock3 = Self(
    checklistId: UUID().uuidString,
    label: "교육과 문서화",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock4 = Self(
    checklistId: UUID().uuidString,
    label: "체크리스트를 생성해보세요",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock5 = Self(
    checklistId: UUID().uuidString,
    label: "체크리스트를 생성해볼까요?1",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock6 = Self(
    checklistId: UUID().uuidString,
    label: "체크리스트를 생성해볼까요?2",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock7 = Self(
    checklistId: UUID().uuidString,
    label: "체크리스트를 생성해볼까요?3",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
  
  static let mock8 = Self(
    checklistId: UUID().uuidString,
    label: "체크리스트를 생성해볼까요?4",
    isCompleted: false,
    isMain: false,
    createdAt: "",
    id: UUID().uuidString
  )
}
