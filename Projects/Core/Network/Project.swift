import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

let project = Project.makeAppModule(
  name: "CoreNetwork",
  bundleId: .appBundleID(name: "Core.Network"),
  product: .staticFramework,
  settings: .settings(),
  dependencies: [
    .shared(implements: .thirdPartyLib)
  ],
  sources: ["Sources/**"]
)
