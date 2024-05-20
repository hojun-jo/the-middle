//
//  ContentView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

struct ContentView: View { // TODO: - DI
  @StateObject private var pathModel = PathModel()
  @StateObject private var homeViewModel = HomeViewModel()
  @StateObject private var mapViewModel = MapViewModel()
  private let naverMapGenerator = NaverMapGenerator()
//  @StateObject private var homeViewModel = HomeViewModel(
//    startLocations: [
//      Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "ㅈㄷㄹ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "튳ㅊ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "ㅈㄷㄱㅅ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "zxcv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "qwer", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "fghj", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "yui", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
//      Location(name: "mnbv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2")
//    ]
//  )
//  @StateObject private var mapViewModel = MapViewModel(
//    searchedLocations: [
//      Location(name: "asdf", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
//      Location(name: "ㄷㄱㅂㅈ", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
//      Location(name: "쇼숀ㅇ호", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㄴㅇㄹㅎ", latitude: "", longitude: ""),
//      Location(name: "ㅌㅊ퓨", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
//      Location(name: "쇼ㅕㅑ", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
//    ]
//  )
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
      HomeView()
        .navigationDestination(
          for: PathType.self,
          destination: { pathType in
            switch pathType {
            case let .mapView(isSearchMode):
              MapView(
                isSearchMode: isSearchMode,
                naverMapGenerator: naverMapGenerator
              )
                .navigationBarBackButtonHidden()
            }
          }
        )
    }
    .environmentObject(pathModel)
    .environmentObject(homeViewModel)
    .environmentObject(mapViewModel)
  }
}

#Preview {
  ContentView()
}
