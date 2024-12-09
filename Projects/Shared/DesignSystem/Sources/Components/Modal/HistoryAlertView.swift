//
//  HistoryAlertView.swift
//  SharedDesignSystem
//
//  Created by 홍은표 on 8/23/24.
//

import SwiftUI

struct HistoryAlertView: View {
  @Binding private var isPresented: Bool
  
  @State private var opacity: Double = 0
  private let animationDuration = 0.1
  
  private let title: String
  private let description: String
  private let cancelText: String
  private let submitText: String
  private var onCancel: (() -> Void)?
  private var onSubmit: (() -> Void)?
  
  init(
    _ isPresented: Binding<Bool>,
    title: String,
    description: String,
    cancelText: String,
    submitText: String,
    onCancel: (() -> Void)?,
    onSubmit: (() -> Void)?
  ) {
    self._isPresented = isPresented
    self.title = title
    self.description = description
    self.cancelText = cancelText
    self.submitText = submitText
    self.onCancel = onCancel
    self.onSubmit = onSubmit
  }
  
  var body: some View {
    ZStack {
      backgroundView
      alertView
    }
    .onAppear {
      show()
    }
  }
  
  private var backgroundView: some View {
    Color.init(hex: "000000")
      .ignoresSafeArea()
      .opacity(opacity * 0.2)
  }
  
  private var alertView: some View {
    VStack(alignment: .leading, spacing: .zero) {
      titleText
      descriptionText
      
      HStack(spacing: 8) {
        cancelButton
        submitButton
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 24)
    }
    .padding(.top, 8)
    .frame(width: 328)
    .background(.greyScale0)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(
      color: Color.black.opacity(0.16),
      radius: 18,
      x: 0,
      y: 8
    )
    .opacity(opacity)
  }
  
  private var titleText: some View {
    Text(title)
      .notoSans(.headline)
      .foregroundStyle(.greyScale950)
      .padding(.vertical, 16)
      .padding(.horizontal, 24)
  }
  
  private var descriptionText: some View {
    Text(description)
      .notoSans(.body_1)
      .foregroundStyle(.greyScale400)
      .padding(.vertical, 8)
      .padding(.horizontal, 24)
  }
  
  private var cancelButton: some View {
    Button(action: {
      dismiss()
      onCancel?()
    }) {
      Text(cancelText)
        .notoSans(.subhead_3)
        .foregroundStyle(.greyScale400)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(.greyScale0)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
          RoundedRectangle(cornerRadius: 8)
            .stroke(.greyScale200, lineWidth: 1)
        )
    }
  }
  
  private var submitButton: some View {
    Button(action: {
      dismiss()
      onSubmit?()
    }) {
      Text(submitText)
        .notoSans(.subhead_3)
        .foregroundStyle(.greyScale0)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(.primary600)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
  
  private func show() {
    withAnimation(.easeOut(duration: animationDuration)) {
      opacity = 1
    }
  }
  
  private func dismiss() {
    withAnimation(.easeOut(duration: animationDuration)) {
      opacity = 0
    } completion: {
      isPresented = false
    }
  }
}
