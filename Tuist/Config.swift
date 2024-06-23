import ProjectDescription

let config = Config(
  swiftVersion: "5.10.0",
  plugins: [
    .local(path: .relativeToRoot("Plugins/ProjectTemplatePlugin")),
    .local(path: .relativeToRoot("Plugins/DependencyPackagePlugin")),
  ],
  generationOptions: .options()
)
