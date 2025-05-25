//
//  JobType.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/5/24.
//

import Foundation



public enum JobType: String, CaseIterable, Identifiable {
  case graphicDesigner
  case artDirector
  case illustrator
  case UIGUIDesigner
  case UXDesigner
  case productDesigner
  case motionDesigner
  case BIBXDesigner
  
  
  case dataEngineer
  case javaDeveloper
  case NETDeveloper
  case networkManager
  case frontEndDeveloper
  case securityEngineer
  case backEndEngineer
  case QAEngineer
  case AndroidDeveloper
  case iOSDeveloper
  
  case productManager
  case servicePlanner
  case dataAnalyst
  case productPlanner
  case operationsManager
  case exhibitionPlanner
  case performancePlanner
  
  public var title: String {
    switch self {
    case .graphicDesigner: return "그래픽 디자이너"
    case .artDirector: return "아트 디렉터"
    case .illustrator: return "일러스트레이터"
    case .UIGUIDesigner: return "UI/GUI 디자이너"
    case .UXDesigner: return "UX 디자이너"
    case .productDesigner: return "제품/산업 디자이너"
    case .motionDesigner: return "영상,모션 디자이너"
    case .BIBXDesigner: return "BI/BX 디자이너"
    
    
    case .dataEngineer: return "데이터 엔지니어"
    case .javaDeveloper: return "자바 개발자"
    case .NETDeveloper: return ".NET 개발자"
    case .networkManager: return "시스템, 네트워크 관리자"
    case .frontEndDeveloper: return "프론트엔드 개발자"
    case .securityEngineer: return "보안 엔지니어"
    case .backEndEngineer: return "백엔드 개발자"
    case .QAEngineer: return "QA,테스트 엔지니어"
    case .AndroidDeveloper: return "안드로이드 개발자"
    case .iOSDeveloper: return "iOS 개발자"
    
    case .productManager: return "PM, PO"
    case .servicePlanner: return "서비스 기획자"
    case .dataAnalyst: return "데이터 분석가"
    case .productPlanner: return "상품 기획자"
    case .operationsManager: return "운영 매니저"
    case .exhibitionPlanner: return "전시 기획자"
    case .performancePlanner: return "공연 기획자"
    }
  }
    
  public var id: Self {
    return self
  }
  
  
  
  
  static let designerJobList: [Self] =
    [.graphicDesigner, .artDirector, .illustrator, .UIGUIDesigner, .UXDesigner, .productDesigner, .BIBXDesigner]

  
  static let developerJobList: [Self] =
    [.dataEngineer, .javaDeveloper, .NETDeveloper, .networkManager, .frontEndDeveloper, .securityEngineer, .backEndEngineer, .QAEngineer, .AndroidDeveloper, .iOSDeveloper]
  
  static let plannerJobList: [Self]  =
    [.productManager, .servicePlanner, .dataAnalyst, .productPlanner, .operationsManager, .exhibitionPlanner, .performancePlanner]
  
}
