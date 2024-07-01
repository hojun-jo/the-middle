//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject, AlertDisplayable {
  
  // MARK: - Public property
  
  @Published var startLocations: [Location]
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  // MARK: - Lifecycle
  
  init(
    startLocations: [Location] = [],
    isDisplayAlert: Bool = false,
    alertMessage: String = ""
  ) {
    self.startLocations = startLocations
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
  }
  
  // MARK: - Public
  
  func averageCoordinate() -> Coordinate? {
    let locationCount: Double = Double(startLocations.count)
    var latitudeSum: Double = 0.0
    var longitudeSum: Double = 0.0
    
    for location in startLocations {
      latitudeSum += location.coordinate.latitude
      longitudeSum += location.coordinate.longitude
    }
    
    return Coordinate(
      latitude: latitudeSum/locationCount,
      longitude: longitudeSum/locationCount
    )
  }
  
  func changeOrAddLocation(
    origin: Location?,
    new: Location
  ) {
    if let origin {
      changeLocation(
        from: origin,
        to: new
      )
    } else {
      startLocations.append(new)
    }
  }
  
  func removeLocation(at index: Int?) {
    if let index,
       0..<startLocations.count ~= index {
      startLocations.remove(at: index)
    }
  }
  
  // MARK: - Private
  
  private func changeLocation(
    from before: Location,
    to after: Location
  ) {
    if let index = startLocations.firstIndex(of: before) {
      startLocations[index] = after
    }
  }
}
