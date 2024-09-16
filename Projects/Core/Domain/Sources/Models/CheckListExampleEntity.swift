//
//  CheckListExampleEntity.swift
//  CoreDomain
//
//  Created by 현수빈 on 9/14/24.
//

import Foundation

public struct CheckListExampleEntity {
  public let title: String
  public let content: String
  public let messsage: String
  
  public static let mock: [Self] = [
    .init(
      title: "업무 보고 회의 준비를 위한",
      content: "체크리스트를 만들어줘",
      messsage: "업무 보고 회의 준비를 위한 체크리스트를 만들어줘"
    ),
    .init(
      title: "팀 프로젝트 일정 관리를 위한",
      content: "체크리스트를 만들어줘",
      messsage: "팀 프로젝트 일정 관리를 위한 체크리스트를 만들어줘"
    ),
    .init(
      title: "데일리 업무 계획을 위한",
      content: "체크리스트를 만들어줘",
      messsage: "데일리 업무 계획을 위한 체크리스트를 만들어줘"
    ),
    .init(
      title: "보고서 초안 작성을 위한 ",
      content: "체크리스트를 만들어줘",
      messsage: "보고서 초안 작성을 위한 체크리스트를 만들어줘"
    )
  ]
}
