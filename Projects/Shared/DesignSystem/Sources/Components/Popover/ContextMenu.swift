//
//  ContextMenu.swift
//  SharedDesignSystem
//
//  Created by eunpyo on 4/15/25.
//

import SwiftUI

public struct ContextMenuItem: Identifiable {
  public let id = UUID()
  public let icon: Image?
  public let title: String
  public let action: () -> Void

  public init(icon: Image?, title: String, action: @escaping () -> Void) {
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
        if let icon = item.icon {
          Button(action: item.action) {
            HStack(spacing: 8) {
              icon
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
        } else {
          Button(action: item.action) {
            Text(item.title)
              .notoSans(.subhead_2)
              .foregroundStyle(.greyScale950)
              .padding(.vertical, 13)
              .padding(.leading, 51)
              .padding(.trailing, 50)
              .contentShape(Rectangle())
          }
          .buttonStyle(.plain)
        }

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

public struct ContextMenuModifier: ViewModifier {
  private let isPresented: Bool
  private let anchorFrame: CGRect?
  private let items: [ContextMenuItem]
  private let alignment: ContextMenuAlignment
  private let onOutsideTap: () -> Void

  public init(
    isPresented: Bool,
    anchorFrame: CGRect?,
    items: [ContextMenuItem],
    alignment: ContextMenuAlignment = .top,
    onOutsideTap: @escaping () -> Void
  ) {
    self.isPresented = isPresented
    self.anchorFrame = anchorFrame
    self.items = items
    self.alignment = alignment
    self.onOutsideTap = onOutsideTap
  }

  public func body(content: Content) -> some View {
    ZStack {
      content

      if isPresented {
        Color.black.opacity(0.001)
          .ignoresSafeArea()
          .layoutPriority(-1)
          .onTapGesture {
            onOutsideTap()
          }

        if let frame = anchorFrame {
          ContextMenuView(items: items)
            .position(alignment.calculatePosition(from: frame))
        }
      }
    }
  }
}

fileprivate extension ContextMenuAlignment {
  func calculatePosition(from frame: CGRect) -> CGPoint {
    let size = CGSize(width: 140, height: 92)

    switch self {
    case .top:
      return .init(
        x: frame.maxX - (size.width / 2),
        y: frame.minY - size.height - 12
      )
    case .bottom:
      return .init(
        x: frame.maxX - (size.width / 2),
        y: frame.maxY + 12
      )
    }
  }
}
