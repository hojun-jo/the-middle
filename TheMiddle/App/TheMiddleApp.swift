//
//  TheMiddleApp.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

@main
struct TheMiddleApp: App {
  @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}

let dummyLocations: [Location] = [
  Location(name: "asdf", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "qwer", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "zxcv", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "erty", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "dfgh", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "cvbn", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "uoiyui", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
  Location(name: "hjkj", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)!),
]
