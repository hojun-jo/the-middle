//
//  NaverMapGenerator.swift
//  TheMiddle
//
//  Created by 조호준 on 5/20/24.
//

import NMapsMap

final class NaverMapGenerator {
  
  // MARK: - Private property
  
  private var map: NMFMapView
  
  // MARK: - Lifecycle
  
  init(map: NMFMapView = .init()) {
    self.map = map
  }
  
  // MARK: - Public
  
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
  
  // MARK: - Private
  
  private func reset() {
    map = .init()
  }
  
  private func generateCurrentMap(coordinate: Coordinate?) throws {
    guard let coordinate else {
      throw MapError.notFoundCurrentCoordinate
    }
    
    addMarker(
      position: coordinate,
      color: .green
    )
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
      addMarker(
        position: location.coordinate,
        color: .green
      )
    }
    
    addMarker(
      position: middleLocation.coordinate,
      color: .blue
    )
    setMapCenter(position: middleLocation.coordinate)
  }
  
  private func addMarker(
    position: Coordinate,
    color: UIColor
  ) {
    let marker: NMFMarker = NMFMarker(position: .init(
      lat: position.latitude,
      lng: position.longitude
    ))
    
    marker.iconTintColor = color
    marker.mapView = map
  }
  
  private func addPolyLine(
    start: Coordinate,
    destination: Coordinate
  ) {
    let startToDestination: [NMGLatLng] = [
      NMGLatLng(
        lat: start.latitude,
        lng: start.longitude
      ),
      NMGLatLng(
        lat: destination.latitude,
        lng: destination.longitude
      )
    ]
    let lineString: NMGLineString<AnyObject> = NMGLineString(points: startToDestination)
    let polylineOverlay: NMFPolylineOverlay? = NMFPolylineOverlay(lineString)
    
    polylineOverlay?.color = .blue
    polylineOverlay?.mapView = map
  }
  
  private func setMapCenter(position: Coordinate) {
    map.latitude = position.latitude
    map.longitude = position.longitude
  }
}
