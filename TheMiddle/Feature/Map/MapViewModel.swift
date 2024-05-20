//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject, AlertDisplayable {
  @Published var isDisplaySearchResult: Bool
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  private let locationService: LocationService
  private(set) var currentLocation: Location?
  private(set) var middleLocation: Location?
  private(set) var searchedLocations: [Location]
  
  var currentCoordinate: Coordinate? {
    if let currentLocation {
      return currentLocation.coordinate
    }
    if let userCoordinate = locationService.currentCoordinate {
      return userCoordinate
    }
    return nil
  }
  
  init(
    isDisplaySearchResult: Bool = false,
    isDisplayAlert: Bool = false,
    alertMessage: String = "",
    locationService: LocationService = .init(),
    currentLocation: Location? = nil,
    middleLocation: Location? = nil,
    searchedLocations: [Location] = []
  ) {
    self.isDisplaySearchResult = isDisplaySearchResult
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
    self.locationService = locationService
    self.currentLocation = currentLocation
    self.middleLocation = middleLocation
    self.searchedLocations = searchedLocations
  }
}

extension MapViewModel {
  func setCurrentLocation(_ location: Location?) {
    currentLocation = location
  }
  
  func closeSearchResult() {
    isDisplaySearchResult = false
  }
  
  func searchButtonAction(keyword: String) {
    guard keyword != "" else {
      displayAlert(message: .needSearchLocation)
      return
    }
    
    Task {
      await searchLocation(keyword: keyword)
      isDisplaySearchResult = true
    }
  }
  
  func searchSubwayStation(at coordinate: Coordinate) async {
    setCurrentLocation(.init(
      name: "중간지점",
      category: "중간지점",
      roadAddress: "중간지점",
      coordinate: coordinate
    ))
    await searchLocation(keyword: "지하철역")
    setMiddleLocation(searchedLocations.first)
  }
  
  private func setMiddleLocation(_ location: Location?) {
    middleLocation = location
  }
  
  private func searchLocation(keyword: String) async {
    do {
      let coordinate = currentCoordinate?.toString()
      
      searchedLocations = try await locationService.searchLocation(
        keyword: keyword,
        latitude: coordinate?.latitude,
        longitude: coordinate?.longitude
      )
    } catch {
      displayAlert(message: .error(message: error.localizedDescription))
      print(error.localizedDescription)
    }
  }
}
