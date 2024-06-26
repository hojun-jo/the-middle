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
  
  // MARK: - Private
  
  private func setMiddleLocation(_ location: Location?) {
    middleLocation = location
  }
  
  private func searchLocation(keyword: String) async {
    do {
      let coordinate = currentCoordinate?.toString()
      
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
