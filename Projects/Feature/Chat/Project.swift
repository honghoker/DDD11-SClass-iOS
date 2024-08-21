import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "FeatureChat",
  bundleId: .appBundleID(name: "Feature.Chat"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .domain
  ],
  sources: ["Sources/**"]
)
