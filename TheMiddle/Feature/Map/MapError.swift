//
//  MapError.swift
//  TheMiddle
//
//  Created by 조호준 on 5/20/24.
//

import Foundation

enum MapError: LocalizedError {
  case notFoundCurrentCoordinate
  case notFoundMiddleLocation
  
  var errorDescription: String? {
    switch self {
    case .notFoundCurrentCoordinate:
      "현재 위치를 찾을 수 없습니다.\n위치 권한을 확인해주세요."
      
    case .notFoundMiddleLocation:
      "중간 위치를 찾을 수 없습니다.\n잠시 후에 다시 시도해주세요."
    }
  }
}
