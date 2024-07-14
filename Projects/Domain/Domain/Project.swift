import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "Domain",
  bundleId: .appBundleID(name: ".Domain"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    
  ],
  sources: ["Sources/**"]
)
