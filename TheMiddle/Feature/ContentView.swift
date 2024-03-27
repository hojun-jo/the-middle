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
      Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
      Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2")
    ]
  )
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
      HomeView()
        .environmentObject(homeViewModel)
        .navigationDestination(
          for: PathType.self,
          destination: { pathType in
            switch pathType {
            case let .mapView(isSearchMode, location):
              MapView(isSearchMode: isSearchMode, location: location)
                .navigationBarBackButtonHidden()
                .environmentObject(homeViewModel)
            }
          }
        )
    }
    .environmentObject(pathModel)
  }
}

#Preview {
  ContentView()
}
