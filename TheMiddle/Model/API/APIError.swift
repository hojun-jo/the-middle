//
//  APIError.swift
//  TheMiddle
//
//  Created by 조호준 on 3/23/24.
//

import Foundation

enum APIError: LocalizedError {
  case invalidKey
  
  var errorDescription: String? {
    switch self {
    case .invalidKey:
      return "API Key가 잘못 되었습니다."
    }
  }
}
