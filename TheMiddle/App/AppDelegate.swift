//
//  AppDelegate.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import UIKit
import NMapsMap

final class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    NMFAuthManager.shared().clientId = Bundle.naverMapClientID
    
    return true
  }
}
