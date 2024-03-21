//
//  HomeViewModel.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
  @Published var locations: [Location]
  
  init(locations: [Location] = []) {
    self.locations = locations
  }
}
