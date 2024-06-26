//
//  Path.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import Foundation

final class PathModel: ObservableObject {
  
  // MARK: - Public property
  
  @Published var paths: [PathType]
  
  // MARK: - Lifecycle
  
  init(paths: [PathType] = []) {
    self.paths = paths
  }
}
