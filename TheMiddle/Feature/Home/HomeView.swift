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
            if let index = indexSet.first {
              homeViewModel.startLocations.remove(at: index)
            }
          })
          
          LocationButtonView()
        }
        .padding()
        .background(.red)
        .listStyle(.plain)
        
        Button(
          action: {
            guard homeViewModel.startLocations.isEmpty == false else {
              // TODO: - 출발지를 추가해주세요 얼럿
              return
            }
            
            Task {
              let coordinate = homeViewModel.computeAverageCoordinate()
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
        .padding()
        .frame(width: geometry.size.width)
        .background(.green)
      }
    }
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
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(.buttonBorder)
        
        Spacer()
      }
    }
    .padding()
    .background(.brown)
  }
}

#Preview {
  HomeView()
    .environmentObject(HomeViewModel(
      startLocations: [
        Location(name: "asdf", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "ㅈㄷㄹ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "튳ㅊ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "ㅈㄷㄱㅅ", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "zxcv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "qwer", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "fghj", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "yui", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2"),
        Location(name: "mnbv", category: "지하철역", address: "서울 성북구", roadAddress: "서울 성북구 ㅇㅇ로", latitude: "2", longitude: "2")
      ]
    ))
    .environmentObject(MapViewModel())
}
