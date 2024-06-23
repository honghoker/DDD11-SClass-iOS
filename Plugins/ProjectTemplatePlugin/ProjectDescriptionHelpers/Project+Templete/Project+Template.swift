//
//  Project+Template.swift
//  ProjectTemplatePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import ProjectDescription

public extension Project {
  static func makeAppModule(
    name: String = Environment.appName,
    bundleId: String,
    platform: Platform = .iOS,
    product: Product,
    packages: [Package] = [],
    deploymentTarget: ProjectDescription.DeploymentTargets = Environment.deploymentTarget,
    destinations: ProjectDescription.Destinations = Environment.deploymentDestination,
    settings: ProjectDescription.Settings,
    scripts: [ProjectDescription.TargetScript] = [],
    dependencies: [ProjectDescription.TargetDependency] = [],
    sources: ProjectDescription.SourceFilesList = ["Sources/**"],
    resources: ProjectDescription.ResourceFileElements? = nil,
    infoPlist: ProjectDescription.InfoPlist = .default,
    entitlements: ProjectDescription.Entitlements? = nil,
    schemes: [ProjectDescription.Scheme] = []
  ) -> Project {
    let appTarget: Target = .target(
      name: name,
      destinations: destinations,
      product: product,
      bundleId: bundleId,
      deploymentTargets: deploymentTarget,
      infoPlist: infoPlist,
      sources: sources,
      resources: resources,
      entitlements: entitlements,
      scripts: scripts,
      dependencies: dependencies
    )
    
    let appDevTarget: Target = .target(
        name: "\(name)-QA",
        destinations: destinations,
        product: product,
        bundleId: bundleId,
        deploymentTargets: deploymentTarget,
        infoPlist: infoPlist,
        sources: sources,
        resources: resources,
        entitlements: entitlements,
        scripts: scripts,
        dependencies: dependencies
    )
    
    let appTestTarget : Target = .target(
        name: "\(name)Tests",
        destinations: destinations,
        product: .unitTests,
        bundleId: "\(bundleId).\(name)Tests",
        deploymentTargets: deploymentTarget,
        infoPlist: .default,
        sources: ["\(name)Tests/Sources/**"],
        dependencies: [.target(name: name)]
    )
    
    let targets = [appTarget, appDevTarget, appTestTarget]
    
    return Project(
        name: name,
        packages: packages,
        settings: settings,
        targets: targets,
        schemes: schemes
    )
  }
}
