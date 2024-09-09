import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeModule(
  name: "CoreCommon",
  bundleId: .appBundleID(name: "Core.Common"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .shared
  ],
  sources: ["Sources/**"]
)
