//
//  Project.swift
//  AppManifests
//
//  Created by 홍은표 on 6/23/24.
//

import DependencyPackagePlugin
import ProjectDescription
import ProjectTemplatePlugin

let infoPlist: [String: Plist.Value] = InfoPlistValues.generateInfoPlist()

let project = Project.makeAppModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID,
    product: .app,
    settings: .appMainSetting,
    scripts: [],
    dependencies: [],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .extendingDefault(with: infoPlist),
    entitlements: nil
)
