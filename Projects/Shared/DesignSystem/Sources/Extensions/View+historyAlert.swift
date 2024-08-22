//
//  View+historyAlert.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

public extension View {
  func historyAlert(
    isPresented: Binding<Bool>,
    title: String,
    description: String,
    cancelText: String,
    confirmText: String,
    onCancel: (() -> Void)? = nil,
    onSubmit: (() -> Void)?
  ) -> some View {
    fullScreenCover(isPresented: isPresented) {
      HistoryAlertView(
        isPresented,
        title: title,
        description: description,
        cancelText: cancelText,
        submitText: confirmText,
        onCancel: onCancel,
        onSubmit: onSubmit
      )
      .presentationBackground(.clear)
    }
    .transaction { transaction in
      transaction.disablesAnimations = true
    }
  }
}
