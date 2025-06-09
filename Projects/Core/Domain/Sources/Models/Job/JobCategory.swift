//
//  JobCategory.swift
//  CoreDomain
//
//  Created by 현수빈 on 5/25/25.
//

import Foundation

public enum JobCategory: String, CaseIterable {
  case designer = "디자이너"
  case developer = "개발자"
  case manager = "기획자"
  
  public static let rootJobList = [
    (JobCategory.designer, JobType.designerJobList),
    (JobCategory.developer, JobType.developerJobList),
    (JobCategory.manager, JobType.plannerJobList)
  ]
}
