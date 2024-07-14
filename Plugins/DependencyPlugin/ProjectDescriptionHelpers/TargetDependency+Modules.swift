//
//  TargetDependency+Modules.swift
//  DependencyPlugin
//
//  Created by 현수빈 on 2024/07/06.
//

import Foundation
import ProjectDescription

// MARK: TargetDependency + App

public extension TargetDependency {
  static var app: Self {
    return .project(target: ModulePath.App.name, path: .app)
  }
  
  static func app(implements module: ModulePath.App) -> Self {
    return .target(name: ModulePath.App.name + module.rawValue)
  }
}

// MARK: TargetDependency + Presentation

public extension TargetDependency {
  static func presentation(implements module: ModulePath.Presentation) -> Self {
    return .project(
      target: module.rawValue,
      path: .presentation(implementation: module)
    )
  }
}

// MARK: TargetDependency + Domain

public extension TargetDependency {
  static func domain(implements module: ModulePath.Domain) -> Self {
    return .project(
      target: module.rawValue,
      path: .domain(implementation: module)
    )
  }
}

// MARK: TargetDependency + Core

public extension TargetDependency {
  static func core(implements module: ModulePath.Core) -> Self {
    return .project(
      target: module.rawValue,
      path: .core(implementation: module)
    )
  }
}

// MARK: TargetDependency + Shared

public extension TargetDependency {
  static func shared(implements module: ModulePath.Shared) -> Self {
    return .project(
      target: module.rawValue,
      path: .shared(implementation: module)
    )
  }
}

// MARK: TargetDependency + DesignSystem

public extension TargetDependency {
  static func designSystem(implements module: ModulePath.DesignSystem) -> Self {
    return .project(
      target: module.rawValue,
      path: .designSystem(implementation: module)
    )
  }
}
