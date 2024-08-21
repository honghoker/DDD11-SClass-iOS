import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "FeatureMyPage",
  bundleId: .appBundleID(name: "Feature.MyPage"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .domain
  ],
  sources: ["Sources/**"]
)
