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
