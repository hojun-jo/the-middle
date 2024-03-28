//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

@MainActor
final class MapViewModel: ObservableObject {
  @Published var searchedLocations: [Location]
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  let locationService: LocationService
  
  init(
    searchedLocations: [Location] = [],
    isDisplayAlert: Bool = false,
    alertMessage: String = "",
    locationService: LocationService = .init()
  ) {
    self.searchedLocations = searchedLocations
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
    self.locationService = locationService
  }
}

extension MapViewModel {
  func searchLocation(
    keyword: String,
    latitude: String?,
    longitude: String?
  ) {
    Task {
      do {
        searchedLocations = try await locationService.searchLocation(
          keyword: keyword,
          latitude: latitude,
          longitude: longitude
        )
      } catch {
        displayAlert(message: error.localizedDescription)
        print(error.localizedDescription)
      }
    }
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
