import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "SharedDesignSystem",
  bundleId: .appBundleID(name: "Shared.DesignSystem"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [

  ],
  sources: ["Sources/**"]
)
