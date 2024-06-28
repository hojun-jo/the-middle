//
//  Repository.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import Foundation

final class Repository {
  
  // MARK: - Private property
  
  private let networkManager: NetworkManager
  private let deserializer: NetworkDeserializable
  
  // MARK: - Lifecycle
  
  init(
    networkManager: NetworkManager,
    deserializer: NetworkDeserializable
  ) {
    self.networkManager = networkManager
    self.deserializer = deserializer
  }
  
  // MARK: - Public
  
  func fetchLocations(
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
    
    let data: Data = try await networkManager.fetchData(kakaoLocation)
    let locationDTO: KakaoLocationDTO = try deserializer.deserialize(data)
    
    return transform(kakaoLocation: locationDTO)
  }
  
  // MARK: - Private
  
  private func transform(kakaoLocation: KakaoLocationDTO) -> [Location] {
    var locations: [Location] = [Location]()
    
    for locationItem in kakaoLocation.documents {
      guard let latitude: Double = Double(locationItem.latitude),
            let longitude: Double = Double(locationItem.longitude),
            let coordinate: Coordinate = Coordinate(latitude: latitude, longitude: longitude)
      else {
        continue
      }
      
      locations.append(Location(
        name: locationItem.placeName,
        category: locationItem.categoryName,
        roadAddress: locationItem.roadAddressName,
        coordinate: coordinate
      ))
    }
    
    return locations
  }
}
