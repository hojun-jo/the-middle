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
  private let naverMapGenerator: NaverMapGenerator
  
  init(
    isSearchMode: Bool,
    naverMapGenerator: NaverMapGenerator
  ) {
    self.isSearchMode = isSearchMode
    self.naverMapGenerator = naverMapGenerator
  }
  
  var body: some View {
    ZStack {
      NaverMapView(
        isSearchMode: isSearchMode,
        naverMapGenerator: naverMapGenerator
      )
        .ignoresSafeArea()
      
      VStack {
        CustomNavigationBar(
          placeName: .init(initialValue: mapViewModel.currentLocation?.name ?? ""),
          leftButtonAction: {
            mapViewModel.closeSearchResult()
            pathModel.paths.removeLast()
          },
          rightButtonAction: { placeName in
            Task {
              await mapViewModel.searchButtonAction(keyword: placeName)
              mapViewModel.openSearchResult()
            }
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

// MARK: - Naver Map View
private struct NaverMapView: UIViewRepresentable {
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

// MARK: - Search Result List View
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

// MARK: - Search Result Cell View
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(.init("\(location.name)"))
        
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
  MapView(isSearchMode: true, naverMapGenerator: .init())
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

#Preview {
  SearchResultCellView(location: Location(
    name: "asdf",
    category: "지하철역",
    roadAddress: "성북구",
    coordinate: .init(latitude: 0, longitude: 0)!
  ))
}
