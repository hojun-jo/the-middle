//
//  Bundle+.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

extension Bundle {
  static var kakaoAPIKey: String? {
    return fetchAPIKey(domain: "KakaoLocationSearchKey")
  }
  
  static var naverMapClientID: String? {
    return fetchAPIKey(domain: "NaverMapClientID")
  }
  
  static private func fetchAPIKey(domain: String) -> String? {
    guard let file = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
          let plist = NSDictionary(contentsOfFile: file),
          let value = plist[domain] as? String
    else {
      return nil
    }
    
    return value
  }
}
