// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription



#endif

let package = Package(
  name: "OnboardingKit",
  dependencies: [
    .package(
      url: "http://github.com/pointfreeco/swift-composable-architecture",
      revision: "1f952d8c69ace5e53bb69a218e6ed00e03a4695c" // 1.11.2
    )
  ]
)
