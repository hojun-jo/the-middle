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
  
  var body: some View {
    NavigationStack(path: $pathModel.paths) {
      HomeView()
        .environmentObject(homeViewModel)
        .navigationDestination(
          for: PathType.self,
          destination: { pathType in
            switch pathType {
            case .homeView:
              HomeView()
                .environmentObject(homeViewModel)
            case .searchView:
              HomeView()// TODO: SearchView()
                .environmentObject(homeViewModel)
            case let .mapView(isComplete):
              HomeView()// TODO: MapView(isComplete, locations)
                .environmentObject(homeViewModel)
            }
          }
        )
    }
  }
}
