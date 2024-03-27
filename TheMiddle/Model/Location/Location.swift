//
//  Location.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class Location {
  var name: String
  var category: String
  var address: String
  var roadAddress: String
  var latitude: Double
  var longitude: Double
  
  init(
    name: String,
    category: String,
    address: String,
    roadAddress: String,
    latitude: Double,
    longitude: Double
  ) {
    self.name = name
    self.category = category
    self.address = address
    self.roadAddress = roadAddress
    self.latitude = latitude
    self.longitude = longitude
  }
}

extension Location: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
    hasher.combine(category)
    hasher.combine(address)
    hasher.combine(roadAddress)
    hasher.combine(latitude)
    hasher.combine(longitude)
  }
  
  static func == (lhs: Location, rhs: Location) -> Bool {
    return lhs.name == rhs.name &&
    lhs.latitude == rhs.latitude &&
    lhs.longitude == rhs.longitude
  }
}
