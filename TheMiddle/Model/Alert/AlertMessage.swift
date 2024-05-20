//
//  AlertMessage.swift
//  TheMiddle
//
//  Created by 조호준 on 4/16/24.
//

enum AlertMessage {
  // MARK: - Error
  case error(message: String)
  
  // MARK: - HomeView
  case needStartLocation
  
  // MARK: - MapView
  case needSearchLocation
  case canNotFindCurrentCoordinate
  case canNotDisplayMiddleLocation
  
  var description: String {
    switch self {
    case .error(message: let message):
      message
    case .needStartLocation:
      "출발지를 추가해 주세요."
    case .needSearchLocation:
      "검색 장소를 입력해주세요."
    case .canNotFindCurrentCoordinate:
      "현재 위치를 찾을 수 없습니다.\n위치 권한을 확인해주세요."
    case .canNotDisplayMiddleLocation:
      "중간 위치를 표시할 수 없습니다."
    }
  }
}
