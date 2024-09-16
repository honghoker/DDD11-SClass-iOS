//
//  ChatAPIClient.swift
//  CoreNetwork
//
//  Created by 현수빈 on 9/8/24.
//

import Foundation

import CoreDomain

import Combine
import CombineMoya
import ComposableArchitecture
import Moya

@DependencyClient
public struct ChatAPIClient: Sendable {
  public var createSession: @Sendable(_ userId: String) async throws -> ChatSession
  public var sendMessage: @Sendable(_ session : ChatSession, _ message: String) async throws -> Message
  public var getMessages: @Sendable(_ sessionId: String) async throws -> ChatSession
}

public extension DependencyValues {
  var chatAPIClient: ChatAPIClient {
    get { self[ChatAPIClient.self] }
    set { self[ChatAPIClient.self] = newValue }
  }
}

extension ChatAPIClient: DependencyKey {
  public static var liveValue: ChatAPIClient = .init(
    createSession: {userId in 
      let api = ChatAPI.createSession(userId)
      let responseDTO: CreateSessionResponseDTO = try await APIService<ChatAPI>().request(api: api)
      
      return responseDTO.toEntity
    },
    sendMessage: { session,message in
      let requestDTO: SendMessageRequestDTO = .init(message: message)
      
      let api = ChatAPI.sendMessage(requestDTO, sessionId: session.sessionId)
      let responseDTO: MessageResponseDTO = try await APIService<ChatAPI>().request(api: api)
      
      return responseDTO.toEntity
    },
    getMessages: { sessionId in
      
      let api = ChatAPI.getMessage(sessionId)
      let responseDTO: CreateSessionResponseDTO = try await APIService<ChatAPI>().request(api: api)
      
      return responseDTO.toEntity
    }
  )
  
  public static var testValue: ChatAPIClient = Self()
}
