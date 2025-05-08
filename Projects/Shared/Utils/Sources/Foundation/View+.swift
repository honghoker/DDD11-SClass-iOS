//
//  View+.swift
//  SharedUtils
//
//  Created by eunpyo on 4/11/25.
//

import SwiftUI

public extension View {
  /// 현재 뷰의 프레임이 변경될 때 지정된 액션을 수행합니다.
  /// - Parameters:
  ///   - space: 좌표를 계산할 기준 공간
  ///   - perform: 프레임 변경 시 실행될 액션
  /// - Returns: 수정된 뷰
  func onFrameChange(
    in space: CoordinateSpace = .global,
    perform action: @escaping (CGRect) -> Void
  ) -> some View {
    background(
      GeometryReader { geometry in
        Color.clear
          .preference(
            key: FramePreferenceKey.self,
            value: geometry.frame(in: space)
          )
      }
    )
    .onPreferenceChange(FramePreferenceKey.self, perform: action)
  }
}

fileprivate struct FramePreferenceKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}
