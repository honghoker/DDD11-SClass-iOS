import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "CoreDomain",
  bundleId: .appBundleID(name: "Core.Domain"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    
  ],
  sources: ["Sources/**"]
)
