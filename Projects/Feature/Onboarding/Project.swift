import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "FeatureOnboarding",
  bundleId: .appBundleID(name: "Feature.Onboarding"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .domain
  ],
  sources: ["Sources/**"]
)
