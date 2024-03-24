//
//  Location.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

struct Location: Hashable {
  var name: String
  var latitude: Double
  var longitude: Double
  
  init(
    name: String,
    latitude: Double,
    longitude: Double
  ) {
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
  }
}
