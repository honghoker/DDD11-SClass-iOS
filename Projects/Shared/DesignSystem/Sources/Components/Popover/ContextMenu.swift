//
//  ContextMenu.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/15/25.
//

import SwiftUI

public struct ContextMenuItem: Identifiable {
  public let id = UUID()
  public let icon: Image
  public let title: String
  public let action: () -> Void

  public init(icon: Image, title: String, action: @escaping () -> Void) {
    self.icon = icon
    self.title = title
    self.action = action
  }
}

public struct ContextMenuView: View {
  private let items: [ContextMenuItem]

  public init(items: [ContextMenuItem]) {
    self.items = items
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(items) { item in
        Button(action: item.action) {
          HStack(spacing: 8) {
            item.icon
              .renderingMode(.template)
              .resizable()
              .scaledToFit()
              .frame(width: 22, height: 22)
              .foregroundStyle(.greyScale950)

            Text(item.title)
              .notoSans(.subhead_2)
              .foregroundStyle(.greyScale950)
          }
          .padding(.vertical, 12)
          .padding(.leading, 21)
          .padding(.trailing, 35)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)

        if item.id != items.last?.id {
          Divider()
            .background(Color.init(hex: "EDEDED"))
        }
      }
    }
    .frame(width: 140)
    .background(.greyScale0)
    .clipShape(.rect(cornerRadius: 10))
    .shadow(
      color: .greyScale950.opacity(0.08),
      radius: 10,
      x: 0,
      y: 4
    )
  }
}
