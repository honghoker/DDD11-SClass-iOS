//
//  ProjectDescription+Path.swift
//  DependencyPlugin
//
//  Created by 송영모 on 2023/04/27.
//

import Foundation
import ProjectDescription

// MARK: ProjectDescription.Path + App

public extension ProjectDescription.Path {
    static var app: Self {
        return .relativeToRoot("Projects/\(ModulePath.App.name)")
    }
}

// MARK: ProjectDescription.Path + Presentation

public extension ProjectDescription.Path {
    static var presentation: Self {
        return .relativeToRoot("Projects/\(ModulePath.Presentation.name)")
    }
    
    static func presentation(implementation module: ModulePath.Presentation) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Presentation.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Domain

public extension ProjectDescription.Path {
    static var domain: Self {
        return .relativeToRoot("Projects/\(ModulePath.Domain.name)")
    }
    
    static func domain(implementation module: ModulePath.Domain) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Domain.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Core

public extension ProjectDescription.Path {
    static var core: Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)")
    }
    
    static func core(implementation module: ModulePath.Core) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Core.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + Shared

public extension ProjectDescription.Path {
    static var shared: Self {
        return .relativeToRoot("Projects/\(ModulePath.Shared.name)")
    }
    
    static func shared(implementation module: ModulePath.Shared) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.Shared.name)/\(module.rawValue)")
    }
}

// MARK: ProjectDescription.Path + DesignSystem

public extension ProjectDescription.Path {
    static var designSystem: Self {
        return .relativeToRoot("Projects/\(ModulePath.DesignSystem.name)")
    }
    
    static func designSystem(implementation module: ModulePath.DesignSystem) -> Self {
        return .relativeToRoot("Projects/\(ModulePath.DesignSystem.name)/\(module.rawValue)")
    }
}
