//
//  PathType.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

enum PathType: Hashable {
  case homeView
  case searchView
  case mapView(isComplete: Bool)
}
