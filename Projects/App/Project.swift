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

let project = Project.makeModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID,
    product: .app,
    settings: .appMainSetting,
    scripts: [],
    dependencies: [
      .feature
    ],
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    infoPlist: .appInfoPlist,
    entitlements: nil
)
