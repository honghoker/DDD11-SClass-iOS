//
//  InfoPlistValues.swift
//  ProjectTemplatePlugin
//
//  Created by 홍은표 on 6/23/24.
//

import Foundation
import ProjectDescription

extension InfoPlist {
  public static let appInfoPlist: Self = .extendingDefault(
    with: InfoPlistDictionary()
      .setUIUserInterfaceStyle("Light")
      .setAppTransportSecurity(arbitaryLoad: true)
      .setCFBundleDevelopmentRegion("$(DEVELOPMENT_LANGUAGE)")
      .setCFBundleExecutable("$(EXECUTABLE_NAME)")
      .setCFBundleIdentifier("$(PRODUCT_BUNDLE_IDENTIFIER)")
      .setCFBundleInfoDictionaryVersion("6.0")
      .setCFBundleName("$(PRODUCT_NAME)")
      .setCFBundlePackageType("APPL")
      .setCFBundleShortVersionString("1.0.0")
      .setCFBundleVersion("1.0.0")
      .setLSRequiresIPhoneOS(true)
      .setUIAppFonts(["PretendardVariable.ttf"])
      .setUIApplicationSceneManifest([
        "UIApplicationSupportsMultipleScenes": true,
        "UISceneConfigurations": [
          "UIWindowSceneSessionRoleApplication": [
            [
              "UISceneConfigurationName": "Default Configuration"
            ]
          ]
        ]
      ])
      .setUILaunchStoryboardName("LaunchScreen.storyboard")
      .setUIRequiredDeviceCapabilities(["armv7"])
      .setUISupportedInterfaceOrientations(["UIInterfaceOrientationPortrait"])
  )
}
