import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeModule(
  name: "Feature",
  bundleId: .appBundleID(name: "Feature"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .feature(implements: .home),
    .domain
  ],
  sources: ["Sources/**"]
)
