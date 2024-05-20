//
//  NaverMapGenerator.swift
//  TheMiddle
//
//  Created by 조호준 on 5/20/24.
//

import NMapsMap

struct NaverMapGenerator {
  private let map: NMFMapView
  
  init(map: NMFMapView = .init()) {
    self.map = map
  }
}

extension NaverMapGenerator {
  func generateMap(
    currentCoordinate: Coordinate,
    middleLocation: Location?,
    startLocations: [Location]
  ) -> NMFMapView {
    if let middleLocation {
      generateMiddleMap(
        middleLocation: middleLocation,
        startLocations: startLocations
      )
    } else {
      generateCurrentMap(coordinate: currentCoordinate)
    }
    
    return map
  }

  private func generateMiddleMap(
    middleLocation: Location,
    startLocations: [Location]
  ) {
    for location in startLocations {
      let latitude = location.coordinate.latitude
      let longitude = location.coordinate.longitude
      
      addPolyLine(
        start: location.coordinate,
        destination: middleLocation.coordinate
      )
      addMarker(position: location.coordinate)
    }
    
    addMarker(position: middleLocation.coordinate)
    setMapCenter(position: middleLocation.coordinate)
  }
  
  private func generateCurrentMap(coordinate: Coordinate) {
    addMarker(position: coordinate)
    setMapCenter(position: coordinate)
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
