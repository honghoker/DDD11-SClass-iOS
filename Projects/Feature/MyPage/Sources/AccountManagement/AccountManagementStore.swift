//
//  AccountManagementStore.swift
//  FeatureMyPage
//
//  Created by 홍은표 on 1/7/25.
//

import SwiftUI

import CoreDomain
import CoreNetwork
import SharedDesignSystem

import ComposableArchitecture

@Reducer
public struct AccountManagementStore {
  public enum SheetType: Identifiable {
    case signOut
    case withdraw
    
    public var id: Self {
      return self
    }
    
    var image: Image {
      return .exit
    }
    
    var title: String {
      switch self {
      case .signOut:
        return "로그아웃 하시겠습니까?"
      case .withdraw:
        return "정말로 탈퇴하시겠습니까?"
      }
    }
    
    var confirmButtonTitle: String {
      switch self {
      case .signOut:
        return "로그아웃"
      case .withdraw:
        return "탈퇴하기"
      }
    }
    
    var cancelButtonTitle: String {
      return "취소"
    }
  }
  
  @ObservableState
  public struct State {
    @Shared(.userInfo) var userInfo: UserInfo?
    @Presents var sheet: ConfirmationSheetStore.State?
    var presentedSheet: SheetType?
    
    // TODO: - 연동된 SNS 추가
    var linkedSocialPlatform: String = "Apple"
  }
  
  public enum Action {
    case didTapBackButton
    case didTapLogoutButton
    case didTapWithdrawButton
    
    case showSheet(SheetType)
    
    case navigateToPreviousPage
    case navigateToRoot
    
    case sheet(PresentationAction<ConfirmationSheetStore.Action>)
  }
  
  @Dependency(KeychainClient.self) var keychainClient
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .didTapBackButton:
        return .send(.navigateToPreviousPage)
        
      case .didTapLogoutButton:
        return .send(.showSheet(.signOut))
        
      case .didTapWithdrawButton:
        return .send(.showSheet(.withdraw))
        
      case .showSheet(let type):
        state.presentedSheet = type
        state.sheet = ConfirmationSheetStore.State(
          image: type.image,
          title: type.title,
          confirmButtonTitle: type.confirmButtonTitle,
          cancelButtonTitle: type.cancelButtonTitle
        )
        return .none
        
      case .sheet(.presented(.didTapConfirmButton)):
        guard let presentedSheet = state.presentedSheet else {
          return .none
        }
        
        return .run { send in
          switch presentedSheet {
          case .signOut:
            // TODO: - 로그아웃 API 호출
            debugPrint("로그아웃 API 호출")
          case .withdraw:
            // TODO: - 회원탈퇴 API 호출
            debugPrint("회원탈퇴 API 호출")
          }
          
          keychainClient.signOut()
          await send(.sheet(.dismiss))
          await send(.navigateToRoot)
        }
        
      case .sheet(.presented(.didTapCancelButton)), .sheet(.presented(.didTapCloseButton)):
        return .send(.sheet(.dismiss))
        
      default:
        return .none
      }
    }
    .ifLet(\.$sheet, action: \.sheet) {
      ConfirmationSheetStore()
    }
  }
}
