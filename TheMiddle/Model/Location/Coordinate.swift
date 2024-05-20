//
//  Coordinate.swift
//  TheMiddle
//
//  Created by 조호준 on 4/3/24.
//

struct Coordinate: Hashable {
  let latitude: Double
  let longitude: Double
}

extension Coordinate {
  func toString() -> (latitude: String, longitude: String) {
    return (String(latitude), String(longitude)) // TODO: - 정확한 이니셜라이저 사용
  }
}
