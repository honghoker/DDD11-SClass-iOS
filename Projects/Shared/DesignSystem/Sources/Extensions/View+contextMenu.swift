//
//  View+contextMenu.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/30/25.
//

import SwiftUI

public extension View {
  /// 앵커 프레임을 기준으로 컨텍스트 메뉴를 표시합니다.
  /// - Parameters:
  ///   - isPresented: 메뉴가 표시되는지 여부
  ///   - anchorFrame: 메뉴의 위치를 계산할 기준 프레임
  ///   - items: 메뉴 아이템 목록
  ///   - alignment: 메뉴가 앵커에 정렬되는 방식 (상단 또는 하단)
  ///   - onOutsideTap: 메뉴 밖을 탭했을 때 호출될 액션
  /// - Returns: 컨텍스트 메뉴가 추가된 뷰
  func contextMenu(
    isPresented: Bool,
    anchorFrame: CGRect?,
    items: [ContextMenuItem],
    alignment: ContextMenuAlignment,
    onOutsideTap: @escaping () -> Void
  ) -> some View {
    self.modifier(
      ContextMenuModifier(
        isPresented: isPresented,
        anchorFrame: anchorFrame,
        items: items,
        alignment: alignment,
        onOutsideTap: onOutsideTap
      )
    )
  }
}

public enum ContextMenuAlignment {
  case top, bottom
}
