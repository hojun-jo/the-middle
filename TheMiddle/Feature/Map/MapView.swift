//
//  MapView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import SwiftUI
import NMapsMap

struct MapView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let isSearchMode: Bool
  
  init(isSearchMode: Bool) {
    self.isSearchMode = isSearchMode
  }
  
  var body: some View {
    VStack {
      CustomNavigationBar(
        placename: .init(initialValue: mapViewModel.currentLocation?.name ?? ""),
        leftButtonAction: {
          pathModel.paths.removeLast()
        },
        rightButtonAction: {
          // TODO: - placename이 ""가 아니면 검색
        },
        isSearchMode: isSearchMode
      )
      // TODO: - mapViewModel.currentLocation != nil 현재 위치로 맵뷰 초기화
      NaverMapView()
    }
  }
}

private struct NaverMapView: UIViewRepresentable {
  func makeUIView(context: Context) -> NMFMapView {
    return NMFMapView()
  }
  
  func updateUIView(_ uiView: NMFMapView, context: Context) {
    
  }
}

#Preview {
  MapView(isSearchMode: true)
  .environmentObject(PathModel())
  .environmentObject(MapViewModel())
}
