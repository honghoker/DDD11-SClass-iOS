import ProjectDescription

let config = Config(
  swiftVersion: "5.10.0",
  plugins: [
    .local(path: .relativeToRoot("Plugins/ProjectTemplatePlugin")),
    .local(path: .relativeToRoot("Plugins/DependencyPackagePlugin")),
    .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
  ],
  generationOptions: .options()
)
