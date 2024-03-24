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
  
  override init() {
    super.init()
    
    locationManager.delegate = self
  }
}

extension LocationService {
  func currentLocation() throws -> (latitude: Double, longitude: Double) {
    guard let coordinate = locationManager.location?.coordinate else {
      throw LocationError.failToGetCurrentLocation
    }
    
    return (coordinate.latitude, coordinate.longitude)
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    switch manager.authorizationStatus {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedAlways, .authorizedWhenInUse:
      manager.startUpdatingLocation()
    case .denied, .restricted:
      manager.stopUpdatingLocation()
    default:
      break
    }
  }
}

enum LocationError: LocalizedError {
  case failToGetCurrentLocation
  
  var errorDescription: String? {
    switch self {
    case .failToGetCurrentLocation:
      return "현재 위치를 가져올 수 없습니다.\n잠시 후 다시 시도해주세요."
    }
  }
}
