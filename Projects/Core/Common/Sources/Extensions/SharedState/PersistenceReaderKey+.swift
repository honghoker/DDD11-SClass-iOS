//
//  PersistenceReaderKey+.swift
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

public extension PersistenceReaderKey where Self == AppStorageKey<[String]> {
  static var searchTerms: Self {
    .appStorage("AppStorageKey.SearchTerms")
  }
}

extension Array: Swift.RawRepresentable where Element: Codable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? JSONDecoder().decode([Element].self, from: data)
    else {
      return nil
    }
    self = result
  }

  public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let result = String(data: data, encoding: .utf8)
    else {
      return "[]"
    }
    return result
  }
}
