//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject, AlertDisplayable {
  @Published var startLocations: [Location]
  
  // MARK: - AlertDisplayalbe
  @Published var isDisplayAlert: Bool
  var isDisplayAlertPublished: Published<Bool> { _isDisplayAlert }
  var isDisplayAlertPublisher: Published<Bool>.Publisher { $isDisplayAlert }
  @Published var alertMessage: String
  var alertMessagePublished: Published<String> { _alertMessage }
  var alertMessagePublisher: Published<String>.Publisher { $alertMessage }
  
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
  func computeAverageCoordinate() -> Coordinate {
    let locationCount = Double(startLocations.count)
    var latitudeSum = 0.0
    var longitudeSum = 0.0
    
    for location in startLocations {
      guard let latitude = Double(location.latitude),
            let longitude = Double(location.longitude)
      else {
        continue
      }
      
      latitudeSum += latitude
      longitudeSum += longitude
    }
    
    return Coordinate(
      latitude: latitudeSum/locationCount,
      longitude: longitudeSum/locationCount
    )
  }
}
