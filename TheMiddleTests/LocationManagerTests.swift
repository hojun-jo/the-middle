//
//  LocationManagerTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 7/1/24.
//

import XCTest
@testable import TheMiddle

final class LocationManagerTests: XCTestCase {
  var sut: LocationManager!
  var dummy: Data!
  var stubCLLocationManager: StubCLLocationManager! = .init()
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    dummy = try JSONEncoder().encode(dummyKakaoLocation)
    sut = .init(
      locationManager: stubCLLocationManager,
      repository: Repository(
        networkManager: .init(session: StubNetworkSession(
          dummy: dummy,
          response: HTTPURLResponse()
        )),
        deserializer: JSONNetworkDeserializer(decoder: .init())
      )
    )
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    
    sut = nil
    dummy = nil
  }
  
  func test_올바른키워드와위경도를입력하면_searchLocation시_올바른Location배열을리턴한다() async throws {
    // given
    let expectation: [Location] = [Location(
      name: "성신여대입구역 4호선",
      category: "교통,수송 > 지하철,전철 > 수도권4호선",
      roadAddress: "서울 성북구 동소문로 지하 102",
      coordinate: .init(
        latitude: 37.59296812939267,
        longitude: 127.0171260607647
      )!
    )]
    
    // when
    let result: [Location] = try await sut.searchLocation(
      keyword: "성신역",
      latitude: "37.59296812939267",
      longitude: "127.0171260607647"
    )
    
    // then
    XCTAssertEqual(result, expectation)
  }
  
  func test_locationManager의location이_nil이아니면_currentCoordinate는올바른값을가진다() {
    // given
    let expectation: Coordinate? = .init(
      latitude: 37.59296812939267,
      longitude: 127.0171260607647
    )
    
    // when
    let result: Coordinate? = sut.currentCoordinate
    
    // then
    XCTAssertEqual(result, expectation)
  }
  
  func test_locationManager의location이_nil이면_currentCoordinate는nil이다() {
    // given
    stubCLLocationManager.location = nil
    
    // when
    let result: Coordinate? = sut.currentCoordinate
    
    // then
    XCTAssertNil(result)
  }
}
