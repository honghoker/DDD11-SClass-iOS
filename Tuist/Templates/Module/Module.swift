//
//  Module.swift
//  Manifests
//
//  Created by 현수빈 on 2024/07/06.
//

import ProjectDescription
import Foundation

let layer = Template.Attribute.required("layer")
let name = Template.Attribute.required("name")
let author: Template.Attribute = .required("author")
let currentDate: Template.Attribute = .optional("currentDate", default: defaultDate)
let year: Template.Attribute = .optional("year", default: defaultYear)

let template = Template(
  description: "A template for a new modules",
  attributes: [
    layer,
    name,
    author,
    currentDate,
    year
  ],
  items: ModuleTemplate.allCases.map { $0.item }
)

fileprivate enum ModuleTemplate: CaseIterable {
  case project
  case baseFile
  case testProject
  
  var item: Template.Item {
    switch self {
    case .project:
      return .file(path: .basePath + "/Project.swift", templatePath: "Project.stencil")
      
    case .baseFile:
      return .file(path: .basePath + "/Sources/Base.swift", templatePath: "base.stencil")
      
    case .testProject:
      return .file(path: .testBasePath + "/Sources/Test.swift", templatePath: "test.stencil")
    }
  }
}

fileprivate extension String {
  static var basePath: Self {
    return "Projects/\(layer)/\(name)"
  }
  
  static var testBasePath: Self {
    return "Projects/\(layer)/\(name)/\(layer)\(name)Tests"
  }
}

fileprivate var defaultDate: Template.Attribute.Value {
  let today = Date()
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy/MM/dd"
  let formattedDate = formatter.string(from: today)
  return .string(formattedDate)
}

fileprivate var defaultYear: Template.Attribute.Value {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy"
  return .string(dateFormatter.string(from: Date()))
}
