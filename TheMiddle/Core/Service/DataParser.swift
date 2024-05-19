//
//  DataParser.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

enum DataParser { // TODO: - DI
  static func kakaoLocation(_ data: Data) throws -> [Location] {
    let locationDTO = try JSONDecoder().decode(KakaoLocationDTO.self, from: data)
    var locations = [Location]()
    
    for locationItem in locationDTO.documents {
      locations.append(Location(
        name: locationItem.placeName,
        category: locationItem.categoryName,
        address: locationItem.addressName,
        roadAddress: locationItem.roadAddressName,
        latitude: locationItem.latitude,
        longitude: locationItem.longitude
      ))
    }
    
    return locations
  }
}
