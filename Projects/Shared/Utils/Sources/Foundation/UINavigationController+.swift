//
//  UINavigationController+.swift
//  SharedUtils
//
//  Created by 홍은표 on 1/27/25.
//

import UIKit

// MARK: - Swipe back 활성화

extension UINavigationController: UIKit.UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    // interactivePopGestureRecognizer 인스턴스일 때만 동작
    guard gestureRecognizer != interactivePopGestureRecognizer else {
      return true
    }
    return viewControllers.count > 1
  }
}
