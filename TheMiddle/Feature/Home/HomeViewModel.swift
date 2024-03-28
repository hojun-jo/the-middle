//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
  @Published var startLocations: [Location]
  
  init(startLocations: [Location] = []) {
    self.startLocations = startLocations
  }
}
