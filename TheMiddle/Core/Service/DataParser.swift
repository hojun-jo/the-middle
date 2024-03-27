//
//  DataParser.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

enum DataParser {
  static func searchLocation(
    keyword: String,
    latitude: String?,
    longitude: String?
  ) async throws -> [Location] {
    guard let kakaoLocation = try KakaoLocationAPI(
      keyword: keyword,
      latitude: latitude,
      longitude: longitude
    ) else {
      throw APIError.invalidKey
    }
    
    let data = try await NetworkService.fetchData(kakaoLocation)
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
