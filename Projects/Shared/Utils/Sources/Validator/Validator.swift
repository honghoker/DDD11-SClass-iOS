//
//  Validator.swift
//  SharedUtils
//
//  Created by 홍은표 on 9/4/24.
//

import Foundation

public protocol Validator {
  var pattern: String { get }
  func validate(with object: String) -> Bool
}

extension Validator {
  public func validate(with object: String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    return predicate.evaluate(with: object)
  }
}

public struct NicknameValidator: Validator {
  public init() { }
  
  public let pattern = "^[A-Za-z가-힣]{1,8}$"
}
