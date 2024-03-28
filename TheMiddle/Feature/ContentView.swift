//
//  ContentView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var pathModel = PathModel()
  @StateObject private var homeViewModel = HomeViewModel(
    startLocations: [
      Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "ㅈㄷㄹ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "튳ㅊ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "ㅈㄷㄱㅅ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "zxcv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "qwer", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "fghj", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "yui", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "mnbv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2")
    ]
  )
  @StateObject private var mapViewModel = MapViewModel()
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
      HomeView()
        .environmentObject(homeViewModel)
        .navigationDestination(
          for: PathType.self,
          destination: { pathType in
            switch pathType {
            case let .mapView(isSearchMode):
              MapView(isSearchMode: isSearchMode)
                .navigationBarBackButtonHidden()
            }
          }
        )
    }
    .environmentObject(pathModel)
    .environmentObject(mapViewModel)
  }
}

#Preview {
  ContentView()
}
