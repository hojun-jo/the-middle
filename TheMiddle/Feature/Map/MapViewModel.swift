//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import UIKit

@MainActor
final class MapViewModel: ObservableObject, AlertDisplayable {
  
  // MARK: - Public property
  
  @Published var isDisplaySearchResult: Bool
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  @Published var alertButtons: [AlertButtonItem]
  
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
    alertButtons: [AlertButtonItem] = [],
    locationManager: LocationManager,
    currentLocation: Location? = nil,
    middleLocation: Location? = nil,
    searchedLocations: [Location] = []
  ) {
    self.isDisplaySearchResult = isDisplaySearchResult
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
    self.alertButtons = alertButtons
    self.locationManager = locationManager
    self.currentLocation = currentLocation
    self.middleLocation = middleLocation
    self.searchedLocations = searchedLocations
  }
  
  // MARK: - Public
  
  func setCurrentLocation(_ location: Location?) {
    currentLocation = location
  }
  
  func openSearchResult() {
    isDisplaySearchResult = true
  }
  
  func closeSearchResult() {
    isDisplaySearchResult = false
  }
  
  func searchButtonAction(keyword: String) async {
    guard keyword != "" else {
      searchedLocations = []
      displayAlert(message: .needSearchLocation)
      return
    }
    
    await searchLocation(
      keyword: keyword,
      coordinate: currentCoordinate
    )
  }
  
  func searchSubwayStation(at coordinate: Coordinate?) async {
    await searchLocation(
      keyword: MapNamespace.subwayStation,
      coordinate: coordinate
    )
    setMiddleLocation(searchedLocations.first)
  }
  
  func displayAlert(error: Error) {
    if let error = error as? MapError,
       error == .notFoundCurrentCoordinate {
      displayAlert(
        message: .error(message: error.localizedDescription),
        buttons: [
          .init(
            action: {
              Task {
                await self.openSettings()
              }
            },
            text: UtilityNamespace.setAuthority
          ),
          .init(
            action: {},
            text: UtilityNamespace.cancel
          )
        ]
      )
    } else {
      displayAlert(message: .error(message: error.localizedDescription))
    }
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
  
  private func openSettings() async {
    if let url: URL = .init(string: UIApplication.openSettingsURLString) {
      await UIApplication.shared.open(url)
    }
  }
}
