//
//  Date+.swift
//  SharedUtils
//
//  Created by 홍은표 on 9/13/24.
//

import Foundation

public extension Date {
  /// 지정된 DateFormatter를 사용하여 Date를 문자열로 포맷팅
  /// - Parameter formatter: 사용할 DateFormatter 인스턴스
  /// - Returns: 포맷팅된 날짜 문자열
  func formatted(using formatter: DateFormatter) -> String {
    return formatter.string(from: self)
  }
}

public extension DateFormatter {
  /// 한국어 로케일을 사용하여 날짜를 "년. 월. 일" 형식으로 포맷팅하는 DateFormatter
  ///
  /// - 날짜 스타일: .short (연, 월, 일)
  /// - 시간 스타일: .none (시간 정보 제외)
  /// - 로케일: ko_KR (한국어)
  ///
  /// - Example:
  ///   ```
  ///   let date = Date()
  ///   let formattedDate = DateFormatter.shortForm.string(from: date)
  ///   print(formattedDate) // 출력 예: "2024. 09. 13"
  ///   ```
  static let shortForm: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .init(identifier: "ko_KR")
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
  }()
}
