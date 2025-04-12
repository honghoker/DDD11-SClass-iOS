//
//  ActivityView.swift
//  SharedUtils
//
//  Created by eunpyo on 4/11/25.
//

import SwiftUI
import UIKit

public struct ActivityView: UIViewControllerRepresentable {
  private let activityItems: [Any]
  private let applicationActivities: [UIActivity]? = nil

  public init(activityItems: [Any]) {
    self.activityItems = activityItems
  }

  public func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(
      activityItems: activityItems,
      applicationActivities: nil
    )
    controller.sheetPresentationController?.detents = [.medium()]

    return controller
  }

  public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {

  }
}
