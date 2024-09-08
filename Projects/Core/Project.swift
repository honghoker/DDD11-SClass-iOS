import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeModule(
  name: "Core",
  bundleId: .appBundleID(name: "Core"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .core(implements: .domain),
    .core(implements: .network),
    .shared
  ],
  sources: ["Sources/**"]
)
