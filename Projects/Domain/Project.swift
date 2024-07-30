import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeModule(
  name: "Domain",
  bundleId: .appBundleID(name: "Domain"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .core,
    .domain(implements: .user)
  ],
  sources: ["Sources/**"]
)

