//
//  MapViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/27/24.
//

import Foundation

final class MapViewModel: ObservableObject {
  /*
   searchedLocations
   isDisplayAlert
   alertMessage
   
   */
  
  private let locationService: LocationService
  
  init(locationService: LocationService = .init()) {
    self.locationService = locationService
  }
}
