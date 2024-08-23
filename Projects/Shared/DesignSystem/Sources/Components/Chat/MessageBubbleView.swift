//
//  MessageBubbleView.swift
//  SharedDesignSystem
//
//  Created by 현수빈 on 8/23/24.
//

import SwiftUI

public struct MessageBubbleView: View {
  
  private let type: MessageBubbleType
  private let title: String?
  private let content: String
  
  public init(
    type: MessageBubbleType,
    title: String? = .none,
    content: String
  ) {
    self.type = type
    self.title = title
    self.content = content
  }
  
  public var body: some View {
    
    switch type {
    case .question:
      question
    case .info:
      info
    case .answer:
      answer
    }
  }
  
  private var question: some View {
    HStack {
      Spacer()
      Text(content)
        .notoSans(.body_1)
        .foregroundStyle(Color.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color.primary600)
        .clipShape(
          .rect(
            topLeadingRadius: 16,
            bottomLeadingRadius: 16,
            bottomTrailingRadius: 0,
            topTrailingRadius: 16
          )
        )
    }
  }
  
  
  private var info: some View {
    HStack(alignment: .bottom, spacing: 7) {
      Image.chatbot
        .frame(width: 25)
      
      VStack(alignment: .leading, spacing: 4) {
        if let title {
          Text(title)
            .notoSans(.subhead_2)
            .foregroundStyle(Color.greyScale950)
        }
        
        Text(content)
          .notoSans(.caption)
          .foregroundStyle(Color.greyScale400)
          .multilineTextAlignment(.leading)
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 14)
      .background(Color.greyScale100)
      .clipShape(
        .rect(
          topLeadingRadius: 16,
          bottomLeadingRadius: 0,
          bottomTrailingRadius: 16,
          topTrailingRadius: 16
        )
      )
      .padding(.bottom, 20)
      
      Spacer()
    }
  }
  
  
  private var answer: some View {
    HStack(alignment: .bottom, spacing: 7) {
      Image.chatbot
        .frame(width: 25)
      
      Text(content)
        .notoSans(.body_1)
        .foregroundStyle(Color.greyScale600)
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color.greyScale100)
        .clipShape(
          .rect(
            topLeadingRadius: 16,
            bottomLeadingRadius: 0,
            bottomTrailingRadius: 16,
            topTrailingRadius: 16
          )
        )
        .padding(.bottom, 20)
      
      Spacer()
    }
  }
  
  
}

public enum MessageBubbleType {
  case answer
  case info
  case question
}
