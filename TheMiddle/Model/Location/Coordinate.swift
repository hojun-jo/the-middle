//
//  Coordinate.swift
//  TheMiddle
//
//  Created by 조호준 on 4/3/24.
//

import Foundation

struct Coordinate {
  let latitude: Double
  let longitude: Double
}

extension Coordinate {
  func toString() -> (latitude: String, longitude: String) {
    return (String(latitude), String(longitude)) // TODO: - 정확한 이니셜라이저 사용
  }
}
