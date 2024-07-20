//
//  RootApp.swift
//  OnboardingKit
//
//  Created by 홍은표 on 7/20/24.
//

import Foundation
import SwiftUI
import FeatureHome

@main
struct RootApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  var body: some Scene {
    WindowGroup {
      HomeView()
    }
  }
}
