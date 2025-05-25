//
//  UserInfo.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/5/24.
//

import Foundation

public struct UserInfo: Equatable {
  public let socialType: SocialLoginType
  public let accessToken: String
  public let nickName: String
  public let role: JobCategory
  public let detailRole: JobType
  public let workExperience: Int
  
  public init(
    socialType: SocialLoginType,
    accessToken: String,
    nickName: String,
    role: JobCategory,
    detailRole: JobType,
    workExperience: Int
  ) {
    self.socialType = socialType
    self.accessToken = accessToken
    self.nickName = nickName
    self.role = role
    self.detailRole = detailRole
    self.workExperience = workExperience
  }
}

public extension UserInfo {
  static let mock = Self(
    socialType: .apple,
    accessToken: "mockId",
    nickName: "SClass",
    role: .developer,
    detailRole: .iOSDeveloper,
    workExperience: 3
  )
}
