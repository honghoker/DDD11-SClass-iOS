import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "SharedUtils",
  bundleId: .appBundleID(name: "Shared.Utils"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [

  ],
  sources: ["Sources/**"]
)
