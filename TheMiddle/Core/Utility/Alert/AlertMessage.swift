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
  
  // MARK: - CurrentLocationMapView
  case needSearchLocation
  
  var description: String {
    switch self {
    case .error(message: let message):
      message
      
    case .needStartLocation:
      "출발지를 추가해 주세요."
      
    case .needSearchLocation:
      "검색 장소를 입력해주세요."
    }
  }
}
