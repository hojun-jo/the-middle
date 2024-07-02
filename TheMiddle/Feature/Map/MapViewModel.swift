//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject, AlertDisplayable {
  
  // MARK: - Public property
  
  @Published var isDisplaySearchResult: Bool
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  var currentCoordinate: Coordinate? {
    if let currentLocation {
      return currentLocation.coordinate
    }
    if let userCoordinate = locationManager.currentCoordinate {
      return userCoordinate
    }
    return nil
  }
  
  // MARK: - Private property
  
  private let locationManager: LocationManager
  
  private(set) var currentLocation: Location?
  private(set) var middleLocation: Location?
  private(set) var searchedLocations: [Location]
  
  // MARK: - Lifecycle
  
  init(
    isDisplaySearchResult: Bool = false,
    isDisplayAlert: Bool = false,
    alertMessage: String = "",
    locationManager: LocationManager,
    currentLocation: Location? = nil,
    middleLocation: Location? = nil,
    searchedLocations: [Location] = []
  ) {
    self.isDisplaySearchResult = isDisplaySearchResult
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
    self.locationManager = locationManager
    self.currentLocation = currentLocation
    self.middleLocation = middleLocation
    self.searchedLocations = searchedLocations
  }
  
  // MARK: - Public
  
  func setCurrentLocation(_ location: Location?) {
    currentLocation = location
  }
  
  func closeSearchResult() {
    isDisplaySearchResult = false
  }
  
  func searchButtonAction(keyword: String) async {
    guard keyword != "" else {
      displayAlert(message: .needSearchLocation)
      return
    }
    
    await searchLocation(
      keyword: keyword,
      coordinate: currentCoordinate
    )
    isDisplaySearchResult = true
  }
  
  func searchSubwayStation(at coordinate: Coordinate?) async {
    await searchLocation(
      keyword: "지하철역",
      coordinate: coordinate
    )
    setMiddleLocation(searchedLocations.first)
  }
  
  // MARK: - Private
  
  private func setMiddleLocation(_ location: Location?) {
    middleLocation = location
  }
  
  private func searchLocation(
    keyword: String,
    coordinate: Coordinate?
  ) async {
    do {
      let coordinate: (latitude: String, longitude: String)? = coordinate?.toString()
      
      searchedLocations = try await locationManager.searchLocation(
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
