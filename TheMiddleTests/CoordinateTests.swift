//
//  CoordinateTests.swift
//  CoordinateTests
//
//  Created by 조호준 on 6/28/24.
//

import XCTest
@testable import TheMiddle

final class CoordinateTests: XCTestCase {
  var sut: Coordinate!
  
  override func setUpWithError() throws {
    sut = Coordinate(latitude: 0.0, longitude: 0.0)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_위경도가0일때_toString호출시_문자열로올바르게리턴한다() {
    // given
    sut = .init(latitude: 0.0, longitude: 0.0)
    let expectation: (latitude: String, longitude: String) = ("0.0", "0.0")
    
    // when
    let result: (latitude: String, longitude: String) = sut.toString()
    
    // then
    XCTAssertEqual(result.latitude, expectation.latitude)
    XCTAssertEqual(result.longitude, expectation.longitude)
  }
  
  func test_위경도가0일때_초기화가성공한다() {
    // given
    // when
    sut = .init(latitude: 0.0, longitude: 0.0)
    
    // then
    XCTAssertNotNil(sut)
  }
  
  func test_latitude가음수일때_초기화가실패한다() {
    // given
    // when
    sut = .init(latitude: -1, longitude: 0)
    
    // then
    XCTAssertNil(sut)
  }
  
  func test_longitude가음수일때_초기화가실패한다() {
    // given
    // when
    sut = .init(latitude: 0, longitude: -1)
    
    // then
    XCTAssertNil(sut)
  }
  
  func test_latitude가90초과일때_초기화가실패한다() {
    // given
    // when
    sut = .init(latitude: 91, longitude: 0)
    
    // then
    XCTAssertNil(sut)
  }
  
  func test_longitude가180초과일때_초기화가실패한다() {
    // given
    // when
    sut = .init(latitude: 0, longitude: 181)
    
    // then
    XCTAssertNil(sut)
  }
}
