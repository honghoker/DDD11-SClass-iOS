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

// MARK: TargetDependency + Feature

public extension TargetDependency {
  static func feature(implements module: ModulePath.Feature) -> Self {
    return .project(
      target: ModulePath.Feature.name + module.rawValue,
      path: .feature(implementation: module)
    )
  }
}

// MARK: TargetDependency + Domain

public extension TargetDependency {
  static func domain(implements module: ModulePath.Domain) -> Self {
    return .project(
      target: ModulePath.Domain.name + module.rawValue,
      path: .domain(implementation: module)
    )
  }
}

// MARK: TargetDependency + Core

public extension TargetDependency {
  static func core(implements module: ModulePath.Core) -> Self {
    return .project(
      target: ModulePath.Core.name + module.rawValue,
      path: .core(implementation: module)
    )
  }
}

// MARK: TargetDependency + Shared

public extension TargetDependency {
  static func shared(implements module: ModulePath.Shared) -> Self {
    return .project(
      target: ModulePath.Shared.name + module.rawValue,
      path: .shared(implementation: module)
    )
  }
}
