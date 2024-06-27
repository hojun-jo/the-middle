//
//  LocationManager.swift
//  TheMiddle
//
//  Created by 조호준 on 3/24/24.
//

import CoreLocation

final class LocationManager: NSObject, LocationManagerProtocol {
  
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
  private let repository: Repository
  
  // MARK: - Lifecycle
  
  init(
    locationManager: CLLocationManager = .init(),
    repository: Repository
  ) {
    self.locationManager = locationManager
    self.repository = repository
    
    super.init()
    
    initLocationManager(
      distanceFilter: CLLocationDistanceMax,
      desiredAccuracy: kCLLocationAccuracyKilometer
    )
  }
  
  // MARK: - Public
  
  func searchLocation(
    keyword: String,
    latitude: String?,
    longitude: String?
  ) async throws -> [Location] {
    return try await repository.fetchLocations(
      keyword: keyword,
      latitude: latitude,
      longitude: longitude
    )
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
