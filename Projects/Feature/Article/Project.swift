import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "FeatureArticle",
  bundleId: .appBundleID(name: "Feature.Article"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .domain
  ],
  sources: ["Sources/**"]
)
