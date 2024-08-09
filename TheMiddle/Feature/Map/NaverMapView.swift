//
//  NaverMapView.swift
//  TheMiddle
//
//  Created by 조호준 on 8/9/24.
//

import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let isSearchMode: Bool
  private let naverMapGenerator: NaverMapGenerator
  
  init(
    isSearchMode: Bool,
    naverMapGenerator: NaverMapGenerator
  ) {
    self.isSearchMode = isSearchMode
    self.naverMapGenerator = naverMapGenerator
  }
  
  func makeUIView(context: Context) -> NMFMapView {
    do {
      return try naverMapGenerator.generateMap(
        isSearchMode: isSearchMode,
        currentCoordinate: mapViewModel.currentCoordinate,
        middleLocation: mapViewModel.middleLocation,
        startLocations: homeViewModel.startLocations
      )
    } catch {
      mapViewModel.displayAlert(error: error)
      
      return NMFMapView()
    }
  }
  
  func updateUIView(_ uiView: NMFMapView, context: Context) {
    
  }
}

#Preview {
  NaverMapView(
    isSearchMode: true,
    naverMapGenerator: .init()
  )
}
