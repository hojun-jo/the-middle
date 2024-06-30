//
//  DummyFailAPI.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/30/24.
//

import Foundation
@testable import TheMiddle

struct DummyFailAPI: APIType {
  let url: String = ""
  let headers: [String : String]? = nil
  let queryItems: [URLQueryItem]? = nil
}
