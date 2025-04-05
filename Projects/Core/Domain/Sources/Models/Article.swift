//
//  Article.swift
//  CoreDomain
//
//  Created by eunpyo on 4/4/25.
//

import Foundation

public struct Article: Identifiable {
  public let id: Int
  public let category: String
  public let subcategory: String
  public let postDate: Date
  public let source: String
  public let title: String
  public let summary: String
  public let views: Int
  public let thumbnail: String
  public let url: String
  public let hashtags: [String]

  public init(
    id: Int,
    category: String,
    subcategory: String,
    postDate: Date,
    source: String,
    title: String,
    summary: String,
    views: Int,
    thumbnail: String,
    url: String,
    hashtags: [String]
  ) {
    self.id = id
    self.category = category
    self.subcategory = subcategory
    self.postDate = postDate
    self.source = source
    self.title = title
    self.summary = summary
    self.views = views
    self.thumbnail = thumbnail
    self.url = url
    self.hashtags = hashtags
  }
}

public extension Article {
  static let mockArticles: [Article] = [
    .init(
      id: 1,
      category: "개발",
      subcategory: "BRD(Business requirements document) 작성요청",
      postDate: ISO8601DateFormatter().date(from: "2025-03-31T09:41:28Z")!,
      source: "Apple Developer",
      title: "프로젝트 우선순위를 검토하는 법",
      summary: "이 문서는 프로젝트 우선순위를 검토하는 방법에 대해 설명합니다.",
      views: 150,
      thumbnail: "https://picsum.photos/id/101/342/208",
      url: "https://developer.apple.com/example1",
      hashtags: ["프로젝트 관리", "회사생활"]
    ),
    .init(
      id: 2,
      category: "기술",
      subcategory: "iOS 업데이트",
      postDate: ISO8601DateFormatter().date(from: "2017-03-16T17:40:00+09:00")!,
      source: "TechCrunch",
      title: "iOS 16.3 업데이트에 대한 전체 가이드",
      summary: "최신 iOS 업데이트의 새로운 기능과 개선사항을 살펴보세요.",
      views: 300,
      thumbnail: "https://picsum.photos/id/102/342/208",
      url: "https://techcrunch.com/example2",
      hashtags: ["iOS", "업데이트", "가이드"]
    ),
    .init(
      id: 3,
      category: "마케팅",
      subcategory: "소셜 미디어 전략",
      postDate: ISO8601DateFormatter().date(from: "2025-03-31T09:41:28Z")!,
      source: "MarketingPro",
      title: "2025년 소셜 미디어 트렌드",
      summary: "올해 주목해야 할 소셜 미디어 트렌드와 전략들을 알아보세요.",
      views: 200,
      thumbnail: "https://picsum.photos/id/103/342/208",
      url: "https://marketingpro.com/example3",
      hashtags: ["소셜 미디어", "트렌드", "전략"]
    ),
    .init(
      id: 4,
      category: "교육",
      subcategory: "온라인 학습",
      postDate: ISO8601DateFormatter().date(from: "2025-04-02T12:00:00Z")!,
      source: "EduOnline",
      title: "자기주도 학습을 위한 최고의 온라인 리소스",
      summary: "효과적인 자기주도 학습을 위한 온라인 플랫폼과 리소스를 소개합니다.",
      views: 220,
      thumbnail: "https://picsum.photos/id/104/342/208",
      url: "https://eduonline.com/example4",
      hashtags: ["교육", "온라인 학습", "자기주도"]
    )
  ]
}
