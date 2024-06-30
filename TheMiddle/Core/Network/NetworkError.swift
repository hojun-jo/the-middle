//
//  NetworkError.swift
//  TheMiddle
//
//  Created by 조호준 on 6/30/24.
//

import Foundation

enum NetworkError: LocalizedError {
  case invalidURL
  case invalidResponse
  case badStatusCode(_ statusCode: Int)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "유효하지 않은 URL입니다."
      
    case .invalidResponse:
      return "네트워크 응답이 잘못되었습니다."
      
    case .badStatusCode(let statusCode):
      return "\(statusCode) 네트워크 오류입니다."
    }
  }
}
