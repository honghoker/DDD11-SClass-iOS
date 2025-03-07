//
//  JobType.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/5/24.
//

import Foundation

public enum JobType: String, CaseIterable, Identifiable {
  case graphicDesigner = "그래픽 디자이너"
  case artDirector = "아트 디렉터"
  case illustrator = "일러스트레이터"
  case UIGUIDesigner = "UI/GUI 디자이너"
  case UXDesigner = "UX 디자이너"
  case productDesigner = "제품/산업 디자이너"
  case motionDesigner = "영상,모션 디자이너"
  case BIBXDesigner = "BI/BX 디자이너"
  
  
  case dataEngineer = "데이터 엔지니어"
  case javaDeveloper = "자바 개발자"
  case NETDeveloper = ".NET 개발자"
  case networkManager = "시스템, 네트워크 관리자"
  case frontEndDeveloper = "프론트엔드 개발자"
  case securityEngineer = "보안 엔지니어"
  case backEndEngineer = "백엔드 개발자"
  case QAEngineer = "QA,테스트 엔지니어"
  case AOSDeveloper = "안드로이드 개발자"
  case iOSDeveloper = "iOS 개발자"
  
  case productManager = "PM, PO"
  case servicePlanner = "서비스 기획자"
  case dataAnalyst = "데이터 분석가"
  case productPlanner = "상품 기획자"
  case operationsManager = "운영 매니저"
  case exhibitionPlanner = "전시 기획자"
  case performancePlanner = "공연 기획자"
    
  public var id: Self {
    return self
  }
  
  
  public static let rootJobList = [("디자이너", designerJobList), ("개발자", developerJobList), ("기획자", plannerJobList)]
  
  static let designerJobList: [Self] =
    [.graphicDesigner, .artDirector, .illustrator, .UIGUIDesigner, .UXDesigner, .productDesigner, .BIBXDesigner]

  
  static let developerJobList: [Self] =
    [.dataEngineer, .javaDeveloper, .NETDeveloper, .networkManager, .frontEndDeveloper, .securityEngineer, .backEndEngineer, .QAEngineer, .AOSDeveloper, .iOSDeveloper]
  
  static let plannerJobList: [Self]  =
    [.productManager, .servicePlanner, .dataAnalyst, .productPlanner, .operationsManager, .exhibitionPlanner, .performancePlanner]
  
}
