//
//  Project+Enviorment.swift.swift
//  ProjectTemplatePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import ProjectDescription

public extension Project {
  enum Environment {
    public static let appName = "OnboardingKit"
    public static let appDemoName = "OnboardingKit-Demo"
    public static let appDevName = "OnboardingKit-Dev"
    public static let deploymentTarget : ProjectDescription.DeploymentTargets = .iOS("17.0")
    public static let deploymentDestination: ProjectDescription.Destinations = [.iPhone, .iPad]
    // TODO: - TeamId 추가 필요
    public static let organizationTeamId = ""
    public static let bundlePrefix = "io.DDD.OnboardingKit"
    public static let appVersion = "1.0.0"
    public static let mainBundleId = "io.DDD.OnboardingKit"
  }
}
