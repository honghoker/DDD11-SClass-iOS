//
//  Extension+TargetDependencySPM.swift
//  DependencyPackagePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import ProjectDescription

public extension TargetDependency.SPM {
  static let composableArchitecture: TargetDependency = .external(
    name: "ComposableArchitecture",
    condition: .none
  )
}
