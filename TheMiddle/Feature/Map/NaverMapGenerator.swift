//
//  NaverMapGenerator.swift
//  TheMiddle
//
//  Created by 조호준 on 5/20/24.
//

import NMapsMap

final class NaverMapGenerator {
  private var map: NMFMapView
  
  init(map: NMFMapView = .init()) {
    self.map = map
  }
}

extension NaverMapGenerator {
  func generateMap(
    isSearchMode: Bool,
    currentCoordinate: Coordinate?,
    middleLocation: Location?,
    startLocations: [Location]
  ) throws -> NMFMapView {
    reset()
    
    if isSearchMode {
      try generateCurrentMap(coordinate: currentCoordinate)
    } else {
      try generateMiddleMap(
        middleLocation: middleLocation,
        startLocations: startLocations
      )
    }
    
    return map
  }
  
  private func reset() {
    map = .init()
  }
  
  private func generateCurrentMap(coordinate: Coordinate?) throws {
    guard let coordinate else {
      throw MapError.notFoundCurrentCoordinate
    }
    
    addMarker(position: coordinate)
    setMapCenter(position: coordinate)
  }

  private func generateMiddleMap(
    middleLocation: Location?,
    startLocations: [Location]
  ) throws {
    guard let middleLocation else {
      throw MapError.notFoundMiddleLocation
    }
    
    for location in startLocations {
      addPolyLine(
        start: location.coordinate,
        destination: middleLocation.coordinate
      )
      addMarker(position: location.coordinate)
    }
    
    addMarker(position: middleLocation.coordinate)
    setMapCenter(position: middleLocation.coordinate)
  }
  
  private func addMarker(position: Coordinate) {
    let marker = NMFMarker(position: .init(
      lat: position.latitude,
      lng: position.longitude
    ))
    
    marker.mapView = map
  }
  
  private func addPolyLine(
    start: Coordinate,
    destination: Coordinate
  ) {
    let startToDestination = [
      NMGLatLng(
        lat: start.latitude,
        lng: start.longitude
      ),
      NMGLatLng(
        lat: destination.latitude,
        lng: destination.longitude
      )
    ]
    let lineString = NMGLineString(points: startToDestination)
    let polylineOverlay = NMFPolylineOverlay(lineString as! NMGLineString<AnyObject>)
    
    polylineOverlay?.color = .blue
    polylineOverlay?.mapView = map
  }
  
  private func setMapCenter(position: Coordinate) {
    map.latitude = position.latitude
    map.longitude = position.longitude
  }
}
