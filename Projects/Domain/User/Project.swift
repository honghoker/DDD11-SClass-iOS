import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "DomainUser",
  bundleId: .appBundleID(name: "Domain.User"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    
  ],
  sources: ["Sources/**"]
)
