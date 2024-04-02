//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
  @Published var startLocations: [Location]
  
  init(startLocations: [Location] = []) {
    self.startLocations = startLocations
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
