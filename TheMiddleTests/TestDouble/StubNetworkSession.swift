//
//  StubNetworkSession.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/28/24.
//

import Foundation
@testable import TheMiddle

final class StubNetworkSession: NetworkSessionProtocol {
  private let dummy: Data
  private let response: URLResponse
  
  init(
    dummy: Data,
    response: URLResponse
  ) {
    self.dummy = dummy
    self.response = response
  }
  
  func data(
    for request: URLRequest,
    delegate: (URLSessionTaskDelegate)? = nil
  ) async throws -> (Data, URLResponse) {
    return (dummy, response)
  }
}
