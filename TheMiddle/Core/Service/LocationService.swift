//
//  LocationService.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import CoreLocation

final class LocationService: NSObject { // TODO: - DI
  
  // MARK: - Public property
  
  var currentCoordinate: Coordinate? {
    guard let coordinate = locationManager.location?.coordinate else {
      return nil
    }
    
    return Coordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude
    )
  }
  
  // MARK: - Private property
  
  private let locationManager = CLLocationManager()
  
  // MARK: - Lifecycle
  
  override init() {
    super.init()
    // TODO: - locationManager 세팅 메서드 추가
    locationManager.delegate = self
    locationManager.distanceFilter = CLLocationDistanceMax
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
  }
  
  // MARK: - Public
  
  func searchLocation(// TODO: - generic
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
