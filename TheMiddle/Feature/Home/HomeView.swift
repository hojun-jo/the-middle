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
              let coordinate = homeViewModel.averageCoordinate()
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
    .environmentObject(HomeViewModel(
      startLocations: [
        Location(name: "asdf", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "qwer", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "zxcv", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "erty", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "dfgh", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "cvbn", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "uoiyui", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
        Location(name: "hjkj", category: "지하철역", roadAddress: "서울 성북구 ㅇㅇ로", coordinate: .init(latitude: 0, longitude: 0)),
      ]
    ))
    .environmentObject(MapViewModel(
      locationManager: .init(
        repository: .init(
          networkManager: .init(session: NetworkSession(session: .init(configuration: .default))),
          deserializer: JSONNetworkDeserializer(decoder: .init())
        )
      )
    ))
}
