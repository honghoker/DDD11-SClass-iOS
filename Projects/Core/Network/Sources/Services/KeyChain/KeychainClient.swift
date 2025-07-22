//
//  KeychainClient.swift
//  CoreNetwork
//
//  Created by 홍은표 on 9/4/24.
//

import Foundation

import CoreDomain

import ComposableArchitecture
import KeychainAccess

private enum KeychainKey {
  static let accessToken = "accessToken"
  static let refreshToken = "refreshToken"
  static let socialLoginType = "socialLoginType"
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
  
  func removeString(for key: String) {
    try? remove(key)
  }
}

extension KeychainClient {
  public var accessToken: String? {
    let token = getString(for: KeychainKey.accessToken)
    debugPrint(token ?? "")
    return token
  }
  
  public func setAccessToken(_ accessToken: String) {
    setString(accessToken, for: KeychainKey.accessToken)
  }
  
  public var refreshToken: String? {
    return getString(for: KeychainKey.refreshToken)
  }
  
  public func setRefreshToken(_ refreshToken: String) {
    setString(refreshToken, for: KeychainKey.refreshToken)
  }
  
  public var socialLoginType: SocialLoginType? {
    return .init(
      rawValue: getString(for: KeychainKey.socialLoginType) ?? ""
    )
  }
  
  public func setSocialLoginType(_ socialLoginType: String) {
    setString(socialLoginType, for: KeychainKey.socialLoginType)
  }
  
  public var isSignIn: Bool {
    return getString(for: KeychainKey.accessToken) != nil && socialLoginType != nil
  }
  
  public func signOut() {
    removeString(for: KeychainKey.accessToken)
    removeString(for: KeychainKey.socialLoginType)
  }
}

extension KeychainClient: DependencyKey {
  public static var liveValue: Self {
    guard let appIdentifierPrefix = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String else {
      fatalError("AppIdentifierPrefix is not set in Info.plist")
    }
    
    let keychain = Keychain(
      service: "com.DDD.onboarding-kit",
      accessGroup: "\(appIdentifierPrefix)group.com.DDD.onboarding-kit"
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
