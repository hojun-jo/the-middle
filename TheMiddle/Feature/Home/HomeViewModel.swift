//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject, AlertDisplayable {
  @Published var startLocations: [Location]
  @Published var isDisplayAlert: Bool
  @Published var alertMessage: String
  
  init(
    startLocations: [Location] = [],
    isDisplayAlert: Bool = false,
    alertMessage: String = ""
  ) {
    self.startLocations = startLocations
    self.isDisplayAlert = isDisplayAlert
    self.alertMessage = alertMessage
  }
}

extension HomeViewModel {
  func averageCoordinate() -> Coordinate {
    let locationCount = Double(startLocations.count)
    var latitudeSum = 0.0
    var longitudeSum = 0.0
    
    for location in startLocations {
      latitudeSum += location.coordinate.latitude
      longitudeSum += location.coordinate.longitude
    }
    
    return Coordinate(
      latitude: latitudeSum/locationCount,
      longitude: longitudeSum/locationCount
    )
  }
  
  func changeOrAddLocation(origin: Location?, new: Location) {
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
    if let index {
      startLocations.remove(at: index)
    }
  }
  
  private func changeLocation(from before: Location, to after: Location) {
    if let index = startLocations.firstIndex(of: before) {
      startLocations[index] = after
    }
  }
}
