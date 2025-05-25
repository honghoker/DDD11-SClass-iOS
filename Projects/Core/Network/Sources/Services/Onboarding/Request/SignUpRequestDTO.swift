//
//  SignUpRequestDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/7/24.
//

import Foundation

public struct SignUpRequestDTO: Encodable {
  let accessToken: String
  let nickname: String
  let role: String
  let detailRole: String
  let workExperience: Int
  
  public init(accessToken: String, nickname: String, role: String, detailRole: String, workExperience: Int) {
    self.accessToken = accessToken
    self.nickname = nickname
    self.role = role
    self.detailRole = detailRole
    self.workExperience = workExperience
  }
}

public extension SignUpRequestDTO {
  static let mock = Self(
    accessToken: "mockID",
    nickname: "Sclass",
    role: "developer",
    detailRole: "iOS developer",
    workExperience: 3
  )
}
