//
//  LocationManagerProtocol.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

protocol LocationManagerProtocol: AnyObject {
  var currentCoordinate: Coordinate? { get }
  
  func searchLocation(
    keyword: String,
    latitude: String?,
    longitude: String?
  ) async throws -> [Location]
}
