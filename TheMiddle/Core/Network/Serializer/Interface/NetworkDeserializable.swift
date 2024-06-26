//
//  NetworkDeserializable.swift
//  TheMiddle
//
//  Created by 조호준 on 6/26/24.
//

import Foundation

protocol NetworkDeserializable {
  func deserialize<T: Decodable>(_ data: Data) throws -> T
}
