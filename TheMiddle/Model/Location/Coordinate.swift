//
//  Coordinate.swift
//  TheMiddle
//
//  Created by 조호준 on 4/3/24.
//

struct Coordinate: Hashable {
  
  // MARK: - Public property
  
  let latitude: Double
  let longitude: Double
  
  // MARK: - Lifecycle
  
  init?(
    latitude: Double,
    longitude: Double
  ) {
    guard latitude >= 0.0,
          latitude <= 90.0,
          longitude >= 0.0,
          longitude <= 180.0
    else {
      return nil
    }
    
    self.latitude = latitude
    self.longitude = longitude
  }
  
  //MARK: - Public
  
  func toString() -> (
    latitude: String,
    longitude: String
  ) {
    return (
      String(describing: latitude),
      String(describing: longitude)
    )
  }
}
