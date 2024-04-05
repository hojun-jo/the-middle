//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject {
  @Published var currentLocation: Location?
  @Published var searchedLocations: [Location]
  @Published var isDisplaySearchResult: Bool
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  let locationService: LocationService
  
  var currentCoordinate: Coordinate? {
    if let currentLocation,
       let latitude = Double(currentLocation.latitude),
       let longitude = Double(currentLocation.longitude) {
      return Coordinate(
        latitude: latitude,
        longitude: longitude
      )
    } else if let currentLatitude = locationService.currentCoordinate?.latitude,
              let currentLongitude = locationService.currentCoordinate?.longitude {
      return Coordinate(
        latitude: currentLatitude,
        longitude: currentLongitude
      )
    } else {
      return nil
    }
  }
  
  init(
    currentLocation: Location? = nil,
    searchedLocations: [Location] = [],
    isDisplaySearchResult: Bool = false,
    isDisplayAlert: Bool = false,
    alertMessage: String = "",
    locationService: LocationService = .init()
  ) {
    self.currentLocation = currentLocation
    self.searchedLocations = searchedLocations
    self.isDisplaySearchResult = isDisplaySearchResult
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
    self.locationService = locationService
  }
}

extension MapViewModel {
  func setCurrentLocation(_ location: Location?) {
    currentLocation = location
  }
  
  func changeCurrentLocation(to location: Location) {
    currentLocation?.name = location.name
    currentLocation?.category = location.category
    currentLocation?.address = location.address
    currentLocation?.roadAddress = location.roadAddress
    currentLocation?.latitude = location.latitude
    currentLocation?.longitude = location.longitude
  }
  
  func searchLocation(keyword: String) async {
    do {
      let coordinate = currentCoordinate?.toString()
      searchedLocations = try await locationService.searchLocation(
        keyword: keyword,
        latitude: coordinate?.latitude,
        longitude: coordinate?.longitude
      )
    } catch {
      displayAlert(message: error.localizedDescription)
      print(error.localizedDescription)
    }
  }
  
  func searchSubwayStation(at coordinate: Coordinate) async {
    let coordinate = coordinate.toString()
    
    setCurrentLocation(Location(
      name: "중간지점",
      category: "중간지점",
      address: "중간지점",
      roadAddress: "중간지점",
      latitude: coordinate.latitude,
      longitude: coordinate.longitude
    ))
    await searchLocation(keyword: "지하철역")
    setCurrentLocation(searchedLocations.first)
  }
  
  private func displayAlert(message: String) {
    setErrorAlertMessage(message)
    setIsDisplayErrorAlert(true)
  }
  
  private func setErrorAlertMessage(_ message: String) {
    alertMessage = message
  }
  
  private func setIsDisplayErrorAlert(_ isDisplay: Bool) {
    isDisplayAlert = isDisplay
  }
}
