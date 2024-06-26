//
//  NetworkSession.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {
  
  // MARK: - Private property
  
  private let session: URLSession
  
  // MARK: - Lifecycle
  
  init(session: URLSession) {
    self.session = session
  }
  
  // MARK: - Public
  
  func data(
    for request: URLRequest,
    delegate: (URLSessionTaskDelegate)? = nil
  ) async throws -> (Data, URLResponse) {
    return try await session.data(
      for: request,
      delegate: delegate
    )
  }
}
