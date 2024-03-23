//
//  Bundle+.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

extension Bundle {
  static var kakaoAPIKey: String {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist"),
          let plistDictionary = NSDictionary(contentsOfFile: filePath),
          let value = plistDictionary.object(forKey: "KakaoLocationSearchKey") as? String
    else {
      fatalError("Couldn't find Kakao API Key")
    }
    
    return value
  }
}
