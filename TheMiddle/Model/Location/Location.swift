//
//  Location.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

struct Location: Hashable {
  let name: String
  let category: String
  let roadAddress: String
  let coordinate: Coordinate
  
  init(
    name: String,
    category: String,
    roadAddress: String,
    coordinate: Coordinate
  ) {
    self.name = name
    self.category = category
    self.roadAddress = roadAddress
    self.coordinate = coordinate
  }
}
