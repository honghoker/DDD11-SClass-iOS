//
//  UserInfoResponseDTO.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/8/24.
//

import Foundation

import CoreDomain

public struct UserInfoResponseDTO: Decodable {
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
  
  enum CodingKeys: String, CodingKey {
    case userId
    case nickname
    case job
    case workExperience
  }
  
  func toDomain() -> UserInfo {
    return .init(
      socialType: .apple, // TODO: 추후 API 연결 후 수정 필요
      userID: userId,
      nickName: nickname,
      job: JobType(rawValue: job) ?? .iOSDeveloper,
      workExperience: workExperience
    )
  }
}
