//
//  Path.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class PathModel: ObservableObject {
  @Published var paths: [PathType]
  
  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
