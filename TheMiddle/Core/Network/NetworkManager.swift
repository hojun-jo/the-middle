//
//  NetworkManager.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

final class NetworkManager {
  
  // MARK: - Private property
  
  private let session: NetworkSessionProtocol
  
  // MARK: - Lifecycle
  
  init(session: NetworkSessionProtocol) {
    self.session = session
  }
  
  // MARK: - Public
  
  func fetchData<T: APIType>(_ api: T) async throws -> Data {
    let request: URLRequest = try createRequest(api)
    let (data, response) = try await session.data(
      for: request,
      delegate: nil
    )
    
    guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else {
      throw NetworkError.invalidResponse
    }
    
    guard (200..<300) ~= httpResponse.statusCode else {
      throw NetworkError.badStatusCode(httpResponse.statusCode)
    }
    
    return data
  }
  
  // MARK: - Private
  
  private func createRequest<T: APIType>(_ api: T) throws -> URLRequest {
    guard var urlComponents: URLComponents = URLComponents(string: api.url) else {
      throw NetworkError.invalidURL
    }
    
    urlComponents.queryItems = api.queryItems
    
    guard let url: URL = urlComponents.url else {
      throw NetworkError.invalidURL
    }
    
    var request: URLRequest = URLRequest(url: url)
    
    api.headers?.forEach { (key, value) in
      request.addValue(value, forHTTPHeaderField: key)
    }
    
    return request
  }
}

// MARK: - Network Error

enum NetworkError: LocalizedError {
  case invalidURL
  case invalidResponse
  case badStatusCode(_ statusCode: Int)
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return "유효하지 않은 URL입니다."
      
    case .invalidResponse:
      return "서버에서 응답이 잘못되었습니다."
      
    case .badStatusCode(let statusCode):
      return "\(statusCode) 네트워크 오류입니다."
    }
  }
}
