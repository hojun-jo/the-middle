//
//  LocationManager.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import CoreLocation

final class LocationManager: NSObject {
  
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
  
  private let locationManager: CLLocationManager
  
  // MARK: - Lifecycle
  
  init(locationManager: CLLocationManager = .init()) {
    self.locationManager = locationManager
    
    super.init()
    
    initLocationManager(
      distanceFilter: CLLocationDistanceMax,
      desiredAccuracy: kCLLocationAccuracyKilometer
    )
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
    
    let data = try await NetworkManager.fetchData(kakaoLocation)
    
    return try DataParser.kakaoLocation(data)
  }
  
  // MARK: - Private
  
  private func initLocationManager(
    distanceFilter: CLLocationDistance,
    desiredAccuracy: CLLocationAccuracy
  ) {
    locationManager.delegate = self
    locationManager.distanceFilter = distanceFilter
    locationManager.desiredAccuracy = desiredAccuracy
  }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
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
