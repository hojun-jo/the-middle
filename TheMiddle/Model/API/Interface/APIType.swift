//
//  APIType.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

protocol APIType {
  var url: String { get }
  var headers: [String : String]? { get }
  var queryItems: [URLQueryItem]? { get }
}
