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
        placeName: .init(initialValue: mapViewModel.currentLocation?.name ?? ""),
        leftButtonAction: {
          pathModel.paths.removeLast()
        },
        rightButtonAction: { placeName in
          guard placeName != "" else { return }
          
          mapViewModel.searchLocation(keyword: placeName)
          mapViewModel.isDisplaySearchResult = true
        },
        isSearchMode: isSearchMode
      )
      
      NaverMapView()
    }
    .sheet(
      isPresented: $mapViewModel.isDisplaySearchResult,
      content: {
        SearchResultListView()
          .presentationDetents([.large])
      }
    )
    .alert(
      mapViewModel.alertMessage,
      isPresented: $mapViewModel.isDisplayAlert,
      actions: {
        Button(
          action: {},
          label: {
            Text("확인")
          }
        )
      },
      message: {}
    )
  }
}

private struct NaverMapView: UIViewRepresentable {
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  func makeUIView(context: Context) -> NMFMapView {
    guard let coordinate = mapViewModel.currentCoordinate else { return NMFMapView() }
    
    let map = NMFMapView()
    let marker = NMFMarker(position: .init(
      lat: coordinate.latitude,
      lng: coordinate.longitude
    ))
    
    map.latitude = coordinate.latitude
    map.longitude = coordinate.longitude
    map.zoomLevel = 16
    marker.mapView = map
    
    return map
  }
  
  func updateUIView(_ uiView: NMFMapView, context: Context) {
    
  }
}

private struct SearchResultListView: View {
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  fileprivate var body: some View {
    ScrollView(.vertical) {
      ForEach(mapViewModel.searchedLocations, id:\.self) { location in
        SearchResultCellView(location: location)
      }
    }
    .padding(.vertical, 30)
    .padding(.horizontal)
  }
}

private struct SearchResultCellView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let location: Location
  
  fileprivate init(location: Location) {
    self.location = location
  }
  
  fileprivate var body: some View {
    HStack {
      VStack(alignment: .leading) {
        HStack(alignment: .bottom) {
          Text(location.name)
            .font(.title2)
            .foregroundStyle(.blue)
          
          Text(location.category)
            .font(.caption)
            .foregroundStyle(.gray)
        }
        
        Text(location.roadAddress)
          .font(.footnote)
      }
      
      Spacer()
      
      Button(
        action: {
          if mapViewModel.currentLocation != nil {
            mapViewModel.changeCurrentLocation(to: location)
          } else {
            homeViewModel.startLocations.append(location)
          }
          
          pathModel.paths.removeLast()
        },
        label: {
          Text("선택")
        }
      )
      .padding()
      .background(.cyan)
      .clipShape(.buttonBorder)
    }
    .padding()
    .border(.gray)
    .background(.orange)
  }
}

#Preview {
  MapView(isSearchMode: true)
    .environmentObject(PathModel())
    .environmentObject(MapViewModel(
      searchedLocations: [
        Location(name: "asdf", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
        Location(name: "ㄷㄱㅂㅈ", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
        Location(name: "쇼숀ㅇ호", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㄴㅇㄹㅎ", latitude: "", longitude: ""),
        Location(name: "ㅌㅊ퓨", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
        Location(name: "쇼ㅕㅑ", category: "지하철역", address: "ㅁㄴㅇㄹ", roadAddress: "ㅁㄴㅇㄹ", latitude: "", longitude: ""),
      ]
    ))
}

#Preview {
  SearchResultCellView(location: Location(
    name: "asdf",
    category: "지하철역",
    address: "서울",
    roadAddress: "성북구",
    latitude: "",
    longitude: ""
  ))
}
