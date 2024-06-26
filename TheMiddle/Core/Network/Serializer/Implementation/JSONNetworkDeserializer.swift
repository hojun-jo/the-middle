//
//  JSONNetworkDeserializer.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import Foundation

struct JSONNetworkDeserializer: NetworkDeserializable {
  
  // MARK: - Private property
  
  private let decoder: JSONDecoder
  
  // MARK: - Lifecycle
  
  init(decoder: JSONDecoder) {
    self.decoder = decoder
  }
  
  // MARK: - Public
  
  func deserialize<T: Decodable>(_ data: Data) throws -> T {
    return try decoder.decode(
      T.self,
      from: data
    )
  }
}
