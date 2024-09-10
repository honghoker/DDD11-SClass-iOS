//
//  LegalDocument.swift
//  CoreDomain
//
//  Created by 홍은표 on 9/10/24.
//

import Foundation

public struct LegalDocumentSection: Identifiable, Equatable {
  public let id: UUID
  public let title: String
  public let content: String
  
  public init(id: UUID = UUID(), title: String, content: String) {
    self.id = id
    self.title = title
    self.content = content
  }
}

public struct LegalDocument: Identifiable, Equatable {
  public let id: UUID
  public let title: String
  public let sections: [LegalDocumentSection]
  
  public init(id: UUID = UUID(), title: String, sections: [LegalDocumentSection]) {
    self.id = id
    self.title = title
    self.sections = sections
  }
}

// MARK: - 개인정보처리방침

public extension LegalDocument {
  static var privacyPolicy: LegalDocument {
    LegalDocument(
      title: "개인정보처리방침",
      sections: [
        LegalDocumentSection(
          title: "제1조 (목적)",
          content: """
          본 방침은 "신입키트" 앱(이하 "서비스")에서 수집하는 개인정보의 처리 및 보호에 관한 내용을 규정합니다.
          본 서비스는 사회 초년생들이 업무 지식과 직무별 업무 수행을 위해 체크리스트를 제공하여 전문가로 단계별로 성장할 수 있도록 지원합니다.
          """
        ),
        LegalDocumentSection(
          title: "제2조 (수집하는 개인정보의 항목)",
          content: """
          회원가입 시 이메일 주소, 비밀번호, 이름 /닉네임 (선택사항), 직무 분야 서비스 이용 시 이용 기록 (로그인 시간, 이용 시간 등), 체크리스트 사용, 기록, 피드백 및 문의 내용 (선택사항, 서비스 개선 목적)
          """
        ),
        LegalDocumentSection(
          title: "제3조 (개인정보의 수집 목적)",
          content: """
          - 회원 관리 및 서비스 제공
          - 이용자의 서비스 이용에 대한 통계 및 분석
          - 맞춤형 서비스 제공 및 사용자 경험 개선
          - 고객 지원 및 문의 응대
          - 마케팅 및 광고 (이용자의 동의가 있는 경우)
          """
        ),
        LegalDocumentSection(
          title: "제4조 (개인정보의 보유 및 이용 기간)",
          content: """
          서비스 이용과 관련하여 수집된 개인정보는 이용자가 탈퇴할 때까지 보유되며, 이용목적이 달성된 후에는 지체 없이 파기합니다.
          단, 법령에 의한 의무 보존 기간이 있는 경우에는 해당 기간 동안 보유합니다.
          """
        ),
        LegalDocumentSection(
          title: "제5조 (개인정보의 제3자 제공)",
          content: """
          이용자의 개인정보는 원칙적으로 제3자에게 제공되지 않습니다. 단, 다음의 경우에는 예외로 합니다.
          - 법령에 의한 경우
          - 이용자의 동의가 있는 경우
          - 서비스 제공을 위해 필요한 경우 (예: 클라우드 서비스 제공업체)
          """
        ),
        LegalDocumentSection(
          title: "제6조 (개인정보의 안전성 확보 조치)",
          content: """
          서비스는 이용자의 개인정보를 보호하기 위해 다음과 같은 안전성 확보 조치를 취하고 있습니다.
          - 개인정보 접근 제한 및 관리
          - 데이터 암호화
          - 정기적인 보안 점검 및 업데이트
          - 개인정보 처리 직원의 최소화 및 교육
          """
        ),
        LegalDocumentSection(
          title: "제7조 (이용자의 권리)",
          content: """
          이용자는 언제든지 자신의 개인정보를 조회하거나 수정할 수 있으며, 처리 정지를 요청할 수 있습니다.
          이 경우, 서비스는 지체 없이 해당 요청을 처리합니다.
          또한, 이용자는 개인정보의 삭제를 요청할 수 있으며, 이 요청은 법령에 따라 처리됩니다.
          """
        ),
        LegalDocumentSection(
          title: "제8조 (개인정보 처리 방침의 변경)",
          content: """
          본 개인정보 처리 방침은 법률 및 정책의 변화에 따라 수정될 수 있으며, 변경 사항은 앱 내 공지사항을 통해 안내합니다.
          또한, 이용자는 변경된 내용을 지속적으로 확인할 책임이 있습니다.
          """
        ),
        LegalDocumentSection(
          title: "제9조 (문의처)",
          content: """
          개인정보 처리와 관련한 문의는 아래의 연락처로 해주시기 바랍니다.
          이메일: s.class0608@gmail.com
          이 방침은 2024년 9월 20일 부터 시행됩니다.
          """
        )
      ]
    )
  }
}

// MARK: - 서비스 이용약관

public extension LegalDocument {
  static var termsOfService: LegalDocument {
    LegalDocument(
      title: "서비스 이용약관",
      sections: [
        LegalDocumentSection(
          title: "제1조 (목적)",
          content: """
          본 약관은 "신입키트" 앱(이하 "서비스")의 이용에 관한 사항을 규정함으로써, 이용자와 서비스 제공자 간의 권리, 의무 및 책임사항을 정하는 것을 목적으로 합니다.
          """
        ),
        LegalDocumentSection(
          title: "제2조 (정의)",
          content: """
          1. "서비스"란 신입사원 및 사회 초년생을 위한 체크리스트 및 관련 정보를 제공하는 앱을 의미합니다.
          2. "이용자"란 본 약관에 동의하고 서비스에 가입하여 서비스를 이용하는 개인 또는 법인을 의미합니다.
          3. "관리자"란 서비스를 운영하고 관리하는 자를 의미합니다.
          """
        ),
        LegalDocumentSection(
          title: "제3조 (약관의 효력 및 변경)",
          content: """
          1. 본 약관은 서비스에 게시하거나 이용자에게 통지함으로써 효력이 발생합니다.
          2. 관리자는 필요할 경우 본 약관을 변경할 수 있으며, 변경된 약관은 서비스 내 공지사항을 통해 안내합니다. 이용자는 변경된 내용을 확인할 책임이 있습니다.
          """
        ),
        LegalDocumentSection(
          title: "제4조 (서비스 이용 계약)",
          content: """
          1. 서비스 이용 계약은 이용자가 본 약관에 동의하고 회원가입을 완료함으로써 체결됩니다.
          2. 관리자는 다음 각 호에 해당하는 경우에 회원가입을 거부할 수 있습니다.
             1. 가입 신청 시 허위 정보를 기재한 경우
             2. 사회적 통념에 반하는 행위를 한 경우
             3. 기타 관리자가 정한 기준에 부합하지 않는 경우
          """
        ),
        LegalDocumentSection(
          title: "제5조 (서비스의 제공)",
          content: """
          1. 서비스는 이용자에게 체크리스트 및 관련 정보를 제공하며, 서비스의 내용은 관리자의 재량에 따라 변경될 수 있습니다.
          2. 서비스 이용은 24시간 가능하나, 시스템 점검, 유지보수 등의 사유로 일시 중단될 수 있습니다.
          """
        ),
        LegalDocumentSection(
          title: "제6조 (이용자의 의무)",
          content: """
          1. 이용자는 서비스를 이용할 때 다음 각 호의 의무를 준수해야 합니다.
             1. 서비스 이용 시 타인의 권리를 침해하지 않아야 합니다.
             2. 서비스를 통해 얻은 정보를 상업적 목적으로 이용할 수 없습니다.
             3. 서비스 이용 중 타인에게 불편을 주거나 피해를 주지 않아야 합니다.
             4. 자신의 계정 정보를 안전하게 관리해야 하며, 계정의 부정 사용에 대한 책임은 이용자에게 있습니다.
          """
        ),
        LegalDocumentSection(
          title: "제7조 (서비스 이용의 제한)",
          content: """
          1. 관리자는 이용자가 본 약관을 위반한 경우, 서비스 이용을 제한하거나 정지할 수 있습니다.
          2. 이용자가 서비스 이용을 중단하고자 할 경우, 관리자에게 요청하여야 하며, 요청한 날로부터 즉시 처리됩니다.
          """
        ),
        LegalDocumentSection(
          title: "제8조 (저작권 및 지적 재산권)",
          content: """
          1. 서비스에 포함된 모든 콘텐츠(텍스트, 이미지, 소프트웨어 등)에 대한 저작권 및 지적 재산권은 관리자가 소유합니다.
          2. 이용자는 서비스의 콘텐츠를 무단으로 복제, 배포, 전송할 수 없습니다.
          """
        ),
        LegalDocumentSection(
          title: "제9조 (면책 조항)",
          content: """
          1. 관리자는 서비스 이용과 관련하여 발생한 손해에 대해 책임을 지지 않습니다. 단, 고의 또는 중과실로 인한 경우는 제외합니다.
          2. 서비스에 포함된 정보의 정확성 및 신뢰성에 대한 책임은 이용자에게 있습니다.
          """
        ),
        LegalDocumentSection(
          title: "제10조 (분쟁 해결)",
          content: """
          본 약관과 관련하여 발생하는 분쟁은 관리자의 본사 소재지를 관할하는 법원에서 해결합니다.
          """
        ),
        LegalDocumentSection(
          title: "제11조 (약관의 동의 및 효력)",
          content: """
          본 약관은 이용자가 서비스 가입 시 동의함으로써 효력을 발생합니다.
          """
        ),
        LegalDocumentSection(
          title: "제12조 (연락처)",
          content: """
          서비스에 대한 문의는 아래의 연락처로 해주시기 바랍니다.
          이메일: s.class0608@gmail.com
          이 약관은 2024년 9월 20일 부터 시행됩니다.
          """
        )
      ]
    )
  }
}
