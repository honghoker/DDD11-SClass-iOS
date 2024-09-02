//
//  SignUpRequestDTO.swift
//  DomainUser
//
//  Created by 홍은표 on 8/31/24.
//

import Foundation

public struct SignUpRequestDTO: Codable {
  public let userID: String
  public let nickName: String
  public let job: String
  public let workExperience: Int
  
  public init(
    userID: String,
    nickName: String,
    job: String,
    workExperience: Int
  ) {
    self.userID = userID
    self.nickName = nickName
    self.job = job
    self.workExperience = workExperience
  }
  
//  public func toDomain() -> UserInfo {
//    return .init(
//      userID: userID,
//      nickName: nickName,
//      job: JobType(rawValue: job),
//      workExperience: workExperience
//    )
//  }
}

public extension SignUpRequestDTO {
  static let mock = Self(
    userID: "mockId",
    nickName: "SClass",
    job: "developer",
    workExperience: 3
  )
}
