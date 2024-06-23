import Foundation
import ProjectDescription
import ProjectTemplatePlugin


let workspace = Workspace(
name: Project.Environment.appName,
projects: [
    "Projects/**"
])

