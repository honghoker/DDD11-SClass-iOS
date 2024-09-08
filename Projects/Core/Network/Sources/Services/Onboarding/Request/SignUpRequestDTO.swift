//
//  SignUpRequestDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/7/24.
//

import Foundation

public struct SignUpRequestDTO: Encodable {
  let userId: String
  let nickname: String
  let job: String
  let workExperience: Int
  
  public init(userId: String, nickname: String, job: String, workExperience: Int) {
    self.userId = userId
    self.nickname = nickname
    self.job = job
    self.workExperience = workExperience
  }
}

public extension SignUpRequestDTO {
  static let mock = Self(
    userId: "mockID",
    nickname: "Sclass",
    job: "developer",
    workExperience: 3
  )
}
