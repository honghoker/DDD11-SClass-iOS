//
//  Modules.swift
//  DependencyPlugin
//
//  Created by 현수빈 on 2024/07/06.
//

import Foundation
import ProjectDescription

public enum ModulePath {
  case presentation(Presentation)
  case domain(Domain)
  case core(Core)
  case shared(Shared)
  case designSystem(DesignSystem)
}

// MARK: AppModule

public extension ModulePath {
  enum App: String, CaseIterable {
    case iOS
    case iPadOS
    
    public static let name: String = "App"
  }
}

// MARK: PresentationModule

public extension ModulePath {
  enum Presentation: String, CaseIterable {
    case scene
    
    public static let name: String = "Presentation"
  }
}

// MARK: DomainModule

public extension ModulePath {
  enum Domain: String, CaseIterable {
    case user
    
    public static let name: String = "Domain"
  }
}

// MARK: CoreModule

public extension ModulePath {
  enum Core: String, CaseIterable {
    case network
    
    public static let name: String = "Core"
  }
}

// MARK: SharedModule

public extension ModulePath {
  enum Shared: String, CaseIterable {
    case util
    case thirdPartyLib
    
    public static let name: String = "Shared"
  }
}

// MARK: DesignSystemModule

public extension ModulePath {
  enum DesignSystem: String, CaseIterable {
    case font
    
    public static let name: String = "DesignSystem"
  }
}

