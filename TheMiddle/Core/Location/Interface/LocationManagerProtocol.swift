//
//  LocationManagerProtocol.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import CoreLocation

protocol LocationManagerProtocol: AnyObject {
  var location: CLLocation? { get }
  var delegate: CLLocationManagerDelegate? { get set }
  var distanceFilter: CLLocationDistance { get set }
  var desiredAccuracy: CLLocationAccuracy { get set }
}

extension CLLocationManager: LocationManagerProtocol {}
