//
//  TopNavigation.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/16/24.
//

import SwiftUI

public struct TopNavigation: View {
  
  public typealias NavigationItem = (SharedDesignSystemImages, () -> Void)
  
  private let leadingItem: NavigationItem?

  private let centerTitle: String
  
  private let trailingItem: NavigationItem?
  private let trailingButton: (String, () -> Void)?
  
  
  public init(
    leadingItem: NavigationItem? = .none,
    centerTitle: String,
    trailingItem: NavigationItem? = .none,
    trailingButton: (String, () -> Void)? = .none
  ) {
    self.leadingItem = leadingItem
    self.centerTitle = centerTitle
    self.trailingItem = trailingItem
    self.trailingButton = trailingButton
  }
  
  
  public var body: some View {
    HStack(spacing: 0) {
      if let leadingItem {
        navigationItem(leadingItem)
          .padding(.leading, 20)

      }
      
      Spacer()
      
      if let trailingButton {
        Button(action: {
          trailingButton.1()
        }, label: {
          Text(trailingButton.0)
            .font(.notoSans(.body_01))
            .foregroundStyle(Color.primary700)
            .padding(.horizontal, 20)
        })
      }
      
      if let trailingItem {
        navigationItem(trailingItem)
          .padding(.trailing, 16)
      }
    }
    .padding(.vertical, 15)
    .frame(height: 54)
    .frame(maxWidth: .infinity)
    .overlay(alignment: .center) {
      HStack(spacing: 4) {
        Text(centerTitle)
          .font(.notoSans(.subhead_04))
          .foregroundStyle(Color.greyScale950)
      }
    }
  }
  
  @ViewBuilder 
  func navigationItem(_ item: NavigationItem) -> some View {
    Button(action: {
      item.1()
    }, label: {
      item.0.swiftUIImage
        .resizable()
        .scaledToFit()
        .frame(width: 24, height: 24)
        .foregroundStyle(Color.greyScale950)
    })
  }
}
