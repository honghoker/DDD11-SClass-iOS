//
//  UserInfoResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/8/24.
//

import Foundation

import CoreDomain

public struct UserInfoResponseDTO: Decodable {
  let id: Int
  let email: String
  let name: String?
  let nickname: String?
  let role: String?
  let detailRole: String?
  let workExperience: Int
  let socialType: String
  let socialId: String
  
  public init(id: Int, email: String, name: String, nickname: String?, role: String, detailRole: String, workExperience: Int, socialType: String, socialId: String) {
    self.id = id
    self.email = email
    self.name = name
    self.nickname = nickname
    self.role = role
    self.detailRole = detailRole
    self.workExperience = workExperience
    self.socialType = socialType
    self.socialId = socialId
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case email
    case nickname
    case name
    case role
    case detailRole
    case workExperience = "experience"
    case socialType
    case socialId
  }
  
  func toDomain() -> UserInfo {
    return .init(
      socialType: .init(rawValue: socialType.lowercased()) ?? .apple,
      accessToken: id.description,
      nickName: nickname ?? "",
      role: JobCategory(rawValue: role ?? "개발자") ?? .designer,
      detailRole: JobType(rawValue: detailRole ?? "iOS개발자") ?? .iOSDeveloper,
      workExperience: workExperience
    )
  }
}
