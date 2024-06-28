//
//  JSONNetworkDeserializerTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/28/24.
//

import XCTest
@testable import TheMiddle

final class JSONNetworkDeserializerTests: XCTestCase {
  var sut: JSONNetworkDeserializer!
  var dummy: Data!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = JSONNetworkDeserializer(decoder: .init())
    dummy = try JSONEncoder().encode(dummyKakaoLocation)
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    
    sut = nil
    dummy = nil
  }
  
  func test_dummy를_deserialize하면_dummyKakaoLocation과같다() throws {
    // given
    let expectation: KakaoLocationDTO = dummyKakaoLocation
    
    // when
    let result: KakaoLocationDTO = try sut.deserialize(dummy)
    
    // then
    XCTAssertEqual(result, expectation)
  }
}
