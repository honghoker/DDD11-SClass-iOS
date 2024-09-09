//
//  PersistenceReaderKey+UserInfo.swift
//  CoreCommon
//
//  Created by 홍은표 on 9/10/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture

public extension PersistenceReaderKey where Self == InMemoryKey<UserInfo?> {
  static var userInfo: Self { .inMemory("InMemoryKey.UserInfo") }
}
