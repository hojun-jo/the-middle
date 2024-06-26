//
//  NetworkSessionProtocol.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import Foundation

protocol NetworkSessionProtocol {
  func data(
    for request: URLRequest,
    delegate: (URLSessionTaskDelegate)?
  ) async throws -> (Data, URLResponse)
}
