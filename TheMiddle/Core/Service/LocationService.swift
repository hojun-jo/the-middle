//
//  LocationService.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
  private let locationManager = CLLocationManager()
  
  var currentCoordinate: Coordinate? {
    guard let coordinate = locationManager.location?.coordinate else {
      return nil
    }
    
    return Coordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude
    )
  }
  
  override init() {
    super.init()
    
    locationManager.delegate = self
    locationManager.distanceFilter = CLLocationDistanceMax
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
  }
}

extension LocationService {
  func searchLocation(
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
    
    return try DataParser.kakaoLocation(data)
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedAlways, .authorizedWhenInUse:
      manager.startMonitoringSignificantLocationChanges()
    case .denied, .restricted:
      manager.stopUpdatingLocation()
    default:
      break
    }
  }
}
