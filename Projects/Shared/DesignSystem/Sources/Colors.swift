//
//  Colors.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/3/24.
//

import SwiftUI

public extension ShapeStyle where Self == Color {
  static var primary050: Color { .init(asset: SharedDesignSystemAsset.Colors.primary50) }
  static var primary100: Color { .init(asset: SharedDesignSystemAsset.Colors.primary100) }
  static var primary200: Color { .init(asset: SharedDesignSystemAsset.Colors.primary200) }
  static var primary300: Color { .init(asset: SharedDesignSystemAsset.Colors.primary300) }
  static var primary400: Color { .init(asset: SharedDesignSystemAsset.Colors.primary400) }
  static var primary500: Color { .init(asset: SharedDesignSystemAsset.Colors.primary500) }
  static var primary600: Color { .init(asset: SharedDesignSystemAsset.Colors.primary600) }
  static var primary700: Color { .init(asset: SharedDesignSystemAsset.Colors.primary700) }
  static var primary800: Color { .init(asset: SharedDesignSystemAsset.Colors.primary800) }
  static var primary900: Color { .init(asset: SharedDesignSystemAsset.Colors.primary900) }
  static var primary950: Color { .init(asset: SharedDesignSystemAsset.Colors.primary950) }
  
  static var sub050: Color { .init(asset: SharedDesignSystemAsset.Colors.sub50) }
  static var sub100: Color { .init(asset: SharedDesignSystemAsset.Colors.sub100) }
  static var sub200: Color { .init(asset: SharedDesignSystemAsset.Colors.sub200) }
  static var sub300: Color { .init(asset: SharedDesignSystemAsset.Colors.sub300) }
  static var sub400: Color { .init(asset: SharedDesignSystemAsset.Colors.sub400) }
  static var sub500: Color { .init(asset: SharedDesignSystemAsset.Colors.sub500) }
  static var sub600: Color { .init(asset: SharedDesignSystemAsset.Colors.sub600) }
  static var sub700: Color { .init(asset: SharedDesignSystemAsset.Colors.sub700) }
  static var sub800: Color { .init(asset: SharedDesignSystemAsset.Colors.sub800) }
  static var sub900: Color { .init(asset: SharedDesignSystemAsset.Colors.sub900) }
  static var sub950: Color { .init(asset: SharedDesignSystemAsset.Colors.sub950) }
  
  static var greyScale050: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale50) }
  static var greyScale100: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale100) }
  static var greyScale200: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale200) }
  static var greyScale300: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale300) }
  static var greyScale400: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale400) }
  static var greyScale500: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale500) }
  static var greyScale600: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale600) }
  static var greyScale700: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale700) }
  static var greyScale800: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale800) }
  static var greyScale900: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale900) }
  static var greyScale950: Color { .init(asset: SharedDesignSystemAsset.Colors.greyScale950) }
}

fileprivate enum Colors {
  case primary050
  case primary100
  case primary200
  case primary300
  case primary400
  case primary500
  case primary600
  case primary700
  case primary800
  case primary900
  case primary950
  
  case sub050
  case sub100
  case sub200
  case sub300
  case sub400
  case sub500
  case sub600
  case sub700
  case sub800
  case sub900
  case sub950
  
  case greyScale000
  case greyScale050
  case greyScale100
  case greyScale200
  case greyScale300
  case greyScale400
  case greyScale500
  case greyScale600
  case greyScale700
  case greyScale800
  case greyScale900
  case greyScale950
}
