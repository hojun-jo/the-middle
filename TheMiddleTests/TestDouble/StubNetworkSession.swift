//
//  StubNetworkSession.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/28/24.
//

import Foundation
@testable import TheMiddle

final class StubNetworkSession: NetworkSessionProtocol {
  func data(
    for request: URLRequest,
    delegate: (URLSessionTaskDelegate)? = nil
  ) async throws -> (Data, URLResponse) {
    let dummy: Data = try JSONEncoder().encode(dummyKakaoLocation)
    let response: URLResponse = .init()
    
    return (dummy, response)
  }
}
