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
      return "API Key가 잘못 되었습니다.\n개발자에게 알려주시기 바랍니다."
    }
  }
}
