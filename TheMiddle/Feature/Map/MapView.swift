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
    ZStack {
      NaverMapView(isSearchMode: isSearchMode)
        .ignoresSafeArea()
      
      VStack {
        CustomNavigationBar(
          placeName: .init(initialValue: mapViewModel.currentLocation?.name ?? ""),
          leftButtonAction: {
            mapViewModel.closeSearchResult()
            pathModel.paths.removeLast()
          },
          rightButtonAction: { placeName in
            mapViewModel.searchButtonAction(keyword: placeName)
          },
          isSearchMode: isSearchMode
        )
        
        Spacer()
      }
      
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
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  private let isSearchMode: Bool
  
  init(isSearchMode: Bool) {
    self.isSearchMode = isSearchMode
  }
  
  func makeUIView(context: Context) -> NMFMapView { // TODO: - SRP(작은 메서드 여럿으로 분리)
    guard let coordinate = mapViewModel.currentCoordinate else { return NMFMapView() }
    
    let map = NMFMapView()
    
    if isSearchMode == false {
      guard let middleLocation = mapViewModel.middleLocation else {
        mapViewModel.displayAlert(message: .canNotDisplayMiddleLocation)
        return NMFMapView()
      }
      
      for location in homeViewModel.startLocations {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let startToDestination = [
          NMGLatLng(
            lat: latitude,
            lng: longitude
          ),
          NMGLatLng(
            lat: middleLocation.coordinate.latitude,
            lng: middleLocation.coordinate.longitude
          )
        ]
        let lineString = NMGLineString(points: startToDestination)
        let polylineOverlay = NMFPolylineOverlay(lineString as! NMGLineString<AnyObject>)
        polylineOverlay?.color = .blue
        polylineOverlay?.mapView = map
        
        let marker = NMFMarker(position: .init(
          lat: latitude,
          lng: longitude
        ))
        marker.mapView = map
      }
      
      let marker = NMFMarker(position: .init(
        lat: middleLocation.coordinate.latitude,
        lng: middleLocation.coordinate.longitude
      ))
      
      marker.mapView = map
      map.latitude = middleLocation.coordinate.latitude
      map.longitude = middleLocation.coordinate.longitude
    } else {
      let marker = NMFMarker(position: .init(
        lat: coordinate.latitude,
        lng: coordinate.longitude
      ))
      
      marker.mapView = map
      map.latitude = coordinate.latitude
      map.longitude = coordinate.longitude
    }

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
    VStack {
      Rectangle()
        .frame(height: 1)
        .foregroundStyle(.gray)
      
      HStack {
        VStack(alignment: .leading) {
          Text(location.name)
            .font(.title2)
            .foregroundStyle(.blue)
          
          Text(location.category)
            .font(.footnote)
          
          Text(location.roadAddress)
            .font(.caption)
            .foregroundStyle(.gray)
        }
        
        Spacer()
        
        Button(
          action: {
            homeViewModel.changeOrAddLocation(
              origin: mapViewModel.currentLocation,
              new: location
            )
            mapViewModel.closeSearchResult()
            pathModel.paths.removeLast()
          },
          label: {
            Text("선택")
          }
        )
        .padding()
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(.buttonBorder)
      }
      .padding()
    }
  }
}

#Preview {
  MapView(isSearchMode: true)
    .environmentObject(PathModel())
    .environmentObject(MapViewModel(
      searchedLocations: [
        Location(name: "asdf", category: "지하철역", roadAddress: "ㅁㄴㅇㄹ", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "qwer", category: "지하철역", roadAddress: "ㅁㄴㅇㄹ", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "xcv", category: "지하철역", roadAddress: "ㅁㄴㅇㄹ", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "rtyu", category: "지하철역", roadAddress: "ㅁㄴㅇㄹ", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "vgfh", category: "지하철역", roadAddress: "ㅁㄴㅇㄹ", coordinate: .init(latitude: 0, longitude: 0)),
      ]
    ))
}

#Preview {
  SearchResultCellView(location: Location(
    name: "asdf",
    category: "지하철역",
    roadAddress: "성북구",
    coordinate: .init(latitude: 0, longitude: 0)
  ))
}
