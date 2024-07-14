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
  enum App: CapitalizedStringCaseIterable {
    case iOS
    case iPadOS
    
    public static let name: String = "App"
  }
}

// MARK: PresentationModule

public extension ModulePath {
  enum Presentation: CapitalizedStringCaseIterable {
    case home
    
    public static let name: String = "Presentation"
  }
}

// MARK: DomainModule

public extension ModulePath {
  enum Domain: CapitalizedStringCaseIterable {
    case user
    
    public static let name: String = "Domain"
  }
}

// MARK: CoreModule

public extension ModulePath {
  enum Core: CapitalizedStringCaseIterable {
    case network
    
    public static let name: String = "Core"
  }
}

// MARK: SharedModule

public extension ModulePath {
  enum Shared: CapitalizedStringCaseIterable {
    case shareds
    case util
    case thirdPartyLib
    
    public static let name: String = "Shared"
  }
}

// MARK: DesignSystemModule

public extension ModulePath {
  enum DesignSystem: CapitalizedStringCaseIterable {
    case font
    
    public static let name: String = "DesignSystem"
  }
}

// MARK: - CapitalizedString

fileprivate protocol CapitalizedStringCaseIterable: RawRepresentable, CaseIterable where RawValue == String {
  init?(rawValue: String)
}

extension CapitalizedStringCaseIterable {
  public var rawValue: String {
    String(describing: self).capitalized
  }
  
  public init?(rawValue: String) {
    fatalError("This initializer must be overridden by concrete types")
  }
}
