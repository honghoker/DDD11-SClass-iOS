import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "SharedThirdPartyLib",
  bundleId: .appBundleID(name: "Shared.ThirdPartyLib"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [

  ],
  sources: ["Sources/**"]
)
