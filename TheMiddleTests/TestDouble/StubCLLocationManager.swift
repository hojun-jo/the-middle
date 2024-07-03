//
//  StubCLLocationManager.swift
//  TheMiddleTests
//
//  Created by 조호준 on 7/3/24.
//

import CoreLocation
@testable import TheMiddle

final class StubCLLocationManager: LocationManagerProtocol {
  var location: CLLocation? = .init(
    latitude: 37.59296812939267,
    longitude: 127.0171260607647
  )
  var delegate: CLLocationManagerDelegate?
  var distanceFilter: CLLocationDistance = CLLocationDistanceMax
  var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyKilometer
}
