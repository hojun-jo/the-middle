//
//  MiddleSearchResultMapView.swift
//  TheMiddle
//
//  Created by 조호준 on 8/9/24.
//

import SwiftUI

struct MiddleSearchResultMapView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let naverMapGenerator: NaverMapGenerator
  
  init(naverMapGenerator: NaverMapGenerator) {
    self.naverMapGenerator = naverMapGenerator
  }
  
  var body: some View {
    ZStack {
      NaverMapView(
        isSearchMode: false,
        naverMapGenerator: naverMapGenerator
      )
      .ignoresSafeArea()
      
      VStack {
        NavigationBar(
          leftItem: NavigationBackButton {
            pathModel.paths.removeLast()
          },
          centerItem: Text(MapNamespace.middleSearchResult)
        )
        
        Spacer()
      }
    }
    .alert(
      mapViewModel.alertMessage,
      isPresented: $mapViewModel.isDisplayAlert,
      actions: {
        ForEach(mapViewModel.alertButtons, id: \.self) { button in
          Button(
            action: button.action,
            label: { Text(button.text) }
          )
        }
      },
      message: {}
    )
  }
}

#Preview {
  MiddleSearchResultMapView(naverMapGenerator: .init())
  .environmentObject(PathModel())
  .environmentObject(MapViewModel(
    locationManager: .init(
      repository: .init(
        networkManager: .init(session: NetworkSession(session: .init(configuration: .default))),
        deserializer: JSONNetworkDeserializer(decoder: .init())
      )
    ),
    searchedLocations: dummyLocations
  ))
}
