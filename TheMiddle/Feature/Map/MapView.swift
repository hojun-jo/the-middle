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
  @State private var location: Location
  
  private let isSearchMode: Bool
  
  init(
    isSearchMode: Bool,
    location: Location
  ) {
    self.isSearchMode = isSearchMode
    self.location = location
  }
  
  var body: some View {
    VStack {
      CustomNavigationBar(
        placename: $location.name,
        leftButtonAction: {},
        rightButtonAction: {},
        isSearchMode: isSearchMode
      )
      
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
  MapView(
    isSearchMode: true,
    location: Location(
      name: "asdf",
      category: "지하철역",
      address: "서울 ...",
      roadAddress: "도로명 주소",
      latitude: 2,
      longitude: 2
    )
  )
    .environmentObject(PathModel())
    .environmentObject(HomeViewModel())
}
