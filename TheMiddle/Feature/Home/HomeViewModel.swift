//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
  @Published var startLocations: [Location]
  @Published var currentLocation: Location?
  
  init(
    startLocations: [Location] = [],
    currentLocation: Location? = nil
  ) {
    self.startLocations = startLocations
    self.currentLocation = currentLocation
  }
}
