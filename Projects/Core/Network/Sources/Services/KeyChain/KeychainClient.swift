//
//  KeychainClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/4/24.
//

import Foundation

import ComposableArchitecture
import KeychainAccess

private enum KeychainKey {
  static let userID = "userID"
}

public struct KeychainClient: Sendable {
  var get: @Sendable (_ key: String) -> String?
  var set: @Sendable (_ value: String, _ key: String) -> Void
  var remove: @Sendable (_ key: String) throws -> Void
}

extension KeychainClient {
  func getString(for key: String) -> String? {
    return get(key)
  }
  
  func setString(_ value: String, for key: String) {
    set(value, key)
  }
}

extension KeychainClient: DependencyKey {
  public static var liveValue: Self {
    guard let appIdentifierPrefix = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String else {
      fatalError("AppIdentifierPrefix is not set in Info.plist")
    }
    
    let keychain = Keychain(
      service: "io.DDD.OnboardingKit",
      accessGroup: "\(appIdentifierPrefix)group.io.DDD.OnboardingKit"
    )
    
    return Self(
      get: { keychain[$0] },
      set: { keychain[$1] = $0 },
      remove: { keychain[$0] = nil }
    )
  }
}

extension DependencyValues {
  var keychainClient: KeychainClient {
    get { self[KeychainClient.self] }
    set { self[KeychainClient.self] = newValue }
  }
}
