//
//  ContentView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var pathModel = PathModel()
  @StateObject private var homeViewModel = HomeViewModel()
  @StateObject private var mapViewModel = MapViewModel(
    locationManager: .init(
      repository: .init(
        networkManager: .init(session: NetworkSession(session: .init(configuration: .default))),
        deserializer: JSONNetworkDeserializer(decoder: .init())
      )
    )
  )
  private let naverMapGenerator = NaverMapGenerator()
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
      HomeView()
        .navigationDestination(
          for: PathType.self,
          destination: { pathType in
            switch pathType {
            case .currentLocationMapView:
              CurrentLocationMapView(naverMapGenerator: naverMapGenerator)
                .navigationBarBackButtonHidden()
            case .middleSearchResultMapView:
              MiddleSearchResultMapView(naverMapGenerator: naverMapGenerator)
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
