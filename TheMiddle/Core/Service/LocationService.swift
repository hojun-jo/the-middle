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
  func currentLocation() -> (latitude: Double, longitude: Double)? {
    guard let coordinate = locationManager.location?.coordinate else {
      return nil
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
      manager.startMonitoringSignificantLocationChanges()
    case .denied, .restricted:
      manager.stopUpdatingLocation()
    default:
      break
    }
  }
}
