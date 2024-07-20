//
//  Project.swift
//  AppManifests
//
//  Created by 홍은표 on 6/23/24.
//

import DependencyPackagePlugin
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPlugin

let project = Project.makeAppModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID,
    product: .app,
    settings: .appMainSetting,
    scripts: [],
    dependencies: [
      .feature(implements: .home)
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .appInfoPlist,
    entitlements: nil
)
