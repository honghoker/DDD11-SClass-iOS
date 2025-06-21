//
//  Encodable+.swift
//  SharedUtils
//
//  Created by eunpyo on 6/20/25.
//

import Foundation

public extension Encodable {
  func asDictionary() -> [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else {
      return nil
    }
    
    return (
      try? JSONSerialization.jsonObject(
        with: data,
        options: .allowFragments
      )
    ).flatMap { $0 as? [String: Any] }
  }
}
