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
      guard let latitude = Double(locationItem.latitude),
            let longitude = Double(locationItem.longitude)
      else {
        continue
      }
      
      locations.append(Location(
        name: locationItem.placeName,
        category: locationItem.categoryName,
        roadAddress: locationItem.roadAddressName,
        coordinate: .init(
          latitude: latitude,
          longitude: longitude
        )
      ))
    }
    
    return locations
  }
}
