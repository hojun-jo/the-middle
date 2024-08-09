//
//  CurrentLocationMapView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import SwiftUI

struct CurrentLocationMapView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let naverMapGenerator: NaverMapGenerator
  
  init(naverMapGenerator: NaverMapGenerator) {
    self.naverMapGenerator = naverMapGenerator
  }
  
  var body: some View {
    ZStack {
      NaverMapView(
        isSearchMode: true,
        naverMapGenerator: naverMapGenerator
      )
      .ignoresSafeArea()
      
      VStack {
        NavigationBar(
          leftItem: NavigationBackButton {
            mapViewModel.closeSearchResult()
            pathModel.paths.removeLast()
          },
          centerItem: TextField(
            MapNamespace.searchPlaceholder,
            text: $mapViewModel.navigationCenterText
          )
          .autocorrectionDisabled()
          .textFieldStyle(.roundedBorder)
          .accessibilityLabel(.init(MapNamespace.startLocationSearchField)),
          rightItem: Button(
            action: {
              Task {
                await mapViewModel.searchButtonAction(keyword: mapViewModel.navigationCenterText)
                mapViewModel.openSearchResult()
              }
            },
            label: {
              Image(systemName: ImageNamespace.magnifyingglass)
            }
          )
          .accessibilityLabel(.init(UtilityNamespace.search))
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
            Text(UtilityNamespace.choose)
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
  CurrentLocationMapView(naverMapGenerator: .init())
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
