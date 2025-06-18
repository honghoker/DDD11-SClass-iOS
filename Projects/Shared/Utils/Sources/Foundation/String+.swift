//
//  String+.swift
//  SharedUtils
//
//  Created by 현수빈 on 6/18/25.
//
import Foundation

public extension String {
  var relativeDateString: String? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    guard let date = formatter.date(from: self) else {
      return nil
    }
    
    let relativeFormatter = RelativeDateTimeFormatter()
    relativeFormatter.unitsStyle = .full
    relativeFormatter.locale = Locale(identifier: "en_US")
    
    return relativeFormatter.localizedString(for: date, relativeTo: Date())
  }
}
