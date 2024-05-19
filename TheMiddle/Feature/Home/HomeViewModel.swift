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

extension HomeViewModel { // TODO: - 뷰 모델의 역할(기준) 정하고 그에 맞는 메서드인지 판단
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
