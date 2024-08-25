//
//  ChatStore.swift
//  FeatureChat
//
//  Created by 홍은표 on 8/15/24.
//

import Foundation

import Core

import ComposableArchitecture


@Reducer
public struct ChatStore {
  public init() { }
  
  @ObservableState
  public struct State {
    var chatMessage = ""
    var chatList: [MessageEntity] = []
    var isPresented: Bool = false
    
    var session: ChatSession? = nil
    public init() {}
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    
    // 세션 만들기
    case onAppear
    case onCompleteCreateSession(TaskResult<ChatSession>)
    
    // 메세지 보내기
    case didTapSendButton
    case onCompleteSend(TaskResult<Message>)
    
  
    // 예시 체크리스트 생성
    case didTapExmapleButton
    
    
    // 나가기
    case didTapExitButton
    case didTapExitConfirmButton
    case didTapExitCancelButton
    case onCloseView
  }
  
  
  @Dependency(ChatAPIClient.self) var chatAPIClient
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    
    Reduce { state, action in
      switch action {
      case .binding:
        return .none
      case .onAppear:
        return .run { send in
          do {
            let newSession = try await chatAPIClient.createSession()
            await send(.onCompleteCreateSession(.success(newSession)))
          } catch {
            await send(.onCompleteCreateSession(.failure(error)))
          }
        }
      case .onCompleteCreateSession(.success(let response)):
        state.session = response
        return .none
      case .onCompleteCreateSession(.failure(_)):
        return .none
        
        
      case .didTapSendButton:
        state.chatList.append(
          .init(
            title: state.chatMessage,
            content: state.chatMessage,
            type: .question
          )
        )
        return sendMessage(state: &state)
      case .onCompleteSend(.success(let chatResponse)):
        state.chatList.append(
          .init(
            title: chatResponse.text,
            content: chatResponse.text,
            type: .answer
          )
        )
          
        return .none
      case .onCompleteSend(.failure):
        return .none
        
      case .didTapExitButton:
        state.isPresented = true
        return .none
      case .didTapExitConfirmButton:
        state.isPresented = false
        return .send(.onCloseView)
      case .didTapExitCancelButton:
        state.isPresented = false
        return .none
      case .didTapExmapleButton:
        return .none
      case .onCloseView:
        return .none
      }
    }
  }
  
  private func sendMessage(state: inout State) -> Effect<Action> {
    let newMessage = state.chatMessage
    guard let session = state.session
    else { return .none }
    state.chatMessage.removeAll()
    
    return .run { send in
      do {
        let message = try await chatAPIClient.sendMessage(session, newMessage)
        await send(.onCompleteSend(.success(message)))
      } catch {
        await send(.onCompleteSend(.failure(error)))
      }
    }
  }
}

