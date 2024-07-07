//
//  HomeView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var homeViewModel: HomeViewModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .center) {
        List {
          ForEach(homeViewModel.startLocations, id: \.self) { location in
            LocationButtonView(location: location)
          }
          .onDelete(perform: { indexSet in
            homeViewModel.removeLocation(at: indexSet.first)
          })
          
          LocationButtonView()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
            .listRowSeparator(.hidden)
        }
        .padding()
        .listStyle(.plain)
        
        Button(
          action: {
            guard !homeViewModel.startLocations.isEmpty else {
              homeViewModel.displayAlert(message: .needStartLocation)
              return
            }
            
            Task {
              let coordinate: Coordinate? = homeViewModel.averageCoordinate()
              await mapViewModel.searchSubwayStation(at: coordinate)
              pathModel.paths.append(.mapView(isSearchMode: false))
            }
          },
          label: {
            Image(systemName: "magnifyingglass")
              .renderingMode(.template)
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(.white)
              .fontWeight(.bold)
          }
        )
        .frame(width: geometry.size.width)
        .padding(.vertical)
        .background(.green)
      }
    }
    .alert(
      homeViewModel.alertMessage,
      isPresented: $homeViewModel.isDisplayAlert,
      actions: {
        ForEach(homeViewModel.alertButtons, id: \.self) { button in
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

// MARK: - Location Button View
private struct LocationButtonView: View {
  @EnvironmentObject private var pathModel: PathModel
  @EnvironmentObject private var mapViewModel: MapViewModel
  
  private let location: Location?
  
  fileprivate init(location: Location? = nil) {
    self.location = location
  }
  
  fileprivate var body: some View {
    GeometryReader { geometry in
      HStack {
        Spacer()
        
        Button(
          action: {
            mapViewModel.setCurrentLocation(location)
            pathModel.paths.append(.mapView(isSearchMode: true))
          },
          label: {
            Text(location?.name ?? "출발지 추가")
          }
        )
        .frame(width: geometry.size.width * 0.8)
        .font(.title3)
        .clipShape(.buttonBorder)
        
        Spacer()
      }
    }
    .padding()
  }
}

#Preview {
  HomeView()
    .environmentObject(HomeViewModel(startLocations: dummyLocations))
    .environmentObject(MapViewModel(
      locationManager: .init(
        repository: .init(
          networkManager: .init(session: NetworkSession(session: .init(configuration: .default))),
          deserializer: JSONNetworkDeserializer(decoder: .init())
        )
      )
    ))
}
