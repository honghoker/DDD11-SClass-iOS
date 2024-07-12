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
  static var presentation: Self {
    return .project(target: ModulePath.Presentation.name, path: .presentation)
  }
  
  static func presentation(implements module: ModulePath.Presentation) -> Self {
    return .project(
      target: ModulePath.Presentation.name + module.rawValue,
      path: .presentation(implementation: module)
    )
  }
  
  static func presentation(interface module: ModulePath.Presentation) -> Self {
    return .project(
      target: ModulePath.Presentation.name + module.rawValue + "Interface",
      path: .presentation(implementation: module)
    )
  }
  
  static func presentation(tests module: ModulePath.Presentation) -> Self {
    return .project(
      target: ModulePath.Presentation.name + module.rawValue + "Tests",
      path: .presentation(implementation: module)
    )
  }
  
  static func presentation(testing module: ModulePath.Presentation) -> Self {
    return .project(
      target: ModulePath.Presentation.name + module.rawValue + "Testing",
      path: .presentation(implementation: module)
    )
  }
}

// MARK: TargetDependency + Domain

public extension TargetDependency {
  static var domain: Self {
    return .project(target: ModulePath.Domain.name, path: .domain)
  }
  
  static func domain(implements module: ModulePath.Domain) -> Self {
    return .project(
      target: ModulePath.Domain.name + module.rawValue,
      path: .domain(implementation: module)
    )
  }
  
  static func domain(interface module: ModulePath.Domain) -> Self {
    return .project(
      target: ModulePath.Domain.name + module.rawValue + "Interface",
      path: .domain(implementation: module)
    )
  }
  
  static func domain(tests module: ModulePath.Domain) -> Self {
    return .project(
      target: ModulePath.Domain.name + module.rawValue + "Tests",
      path: .domain(implementation: module)
    )
  }
  
  static func domain(testing module: ModulePath.Domain) -> Self {
    return .project(
      target: ModulePath.Domain.name + module.rawValue + "Testing",
      path: .domain(implementation: module)
    )
  }
}

// MARK: TargetDependency + Core

public extension TargetDependency {
  static var core: Self {
    return .project(target: ModulePath.Core.name, path: .core)
  }
  
  static func core(implements module: ModulePath.Core) -> Self {
    return .project(
      target: ModulePath.Core.name + module.rawValue,
      path: .core(implementation: module)
    )
  }
  
  static func core(interface module: ModulePath.Core) -> Self {
    return .project(
      target: ModulePath.Core.name + module.rawValue + "Interface",
      path: .core(implementation: module)
    )
  }
  
  static func core(tests module: ModulePath.Core) -> Self {
    return .project(
      target: ModulePath.Core.name + module.rawValue + "Tests",
      path: .core(implementation: module)
    )
  }
  
  static func core(testing module: ModulePath.Core) -> Self {
    return .project(
      target: ModulePath.Core.name + module.rawValue + "Testing",
      path: .core(implementation: module)
    )
  }
}

// MARK: TargetDependency + Shared

public extension TargetDependency {
  static var shared: Self {
    return .project(target: ModulePath.Shared.name, path: .shared)
  }
  
  static func shared(implements module: ModulePath.Shared) -> Self {
    return .project(
      target: ModulePath.Shared.name + module.rawValue,
      path: .shared(implementation: module)
    )
  }
  
  static func shared(interface module: ModulePath.Shared) -> Self {
    return .project(
      target: ModulePath.Shared.name + module.rawValue + "Interface",
      path: .shared(implementation: module)
    )
  }
}

// MARK: TargetDependency + DesignSystem

public extension TargetDependency {
  static var designSystem: Self {
    return .project(target: ModulePath.DesignSystem.name, path: .designSystem)
  }
  
  static func designSystem(implements module: ModulePath.DesignSystem) -> Self {
    return .project(
      target: ModulePath.DesignSystem.name + module.rawValue,
      path: .designSystem(implementation: module)
    )
  }
}
