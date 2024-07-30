import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "FeatureHome",
  bundleId: .appBundleID(name: "Feature.Home"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .domain
  ],
  sources: ["Sources/**"]
)
