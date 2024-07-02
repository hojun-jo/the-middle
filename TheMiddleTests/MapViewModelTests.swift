//
//  MapViewModelTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 7/1/24.
//

import XCTest
@testable import TheMiddle

@MainActor
final class MapViewModelTests: XCTestCase {
  var sut: MapViewModel!
  var dummyData: Data!
  var dummyLocation: Location!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    dummyData = try JSONEncoder().encode(dummyKakaoLocation)
    sut = .init(locationManager: .init(
      repository: .init(
        networkManager: .init(session: StubNetworkSession(
          dummy: dummyData,
          response: HTTPURLResponse()
        )),
        deserializer: JSONNetworkDeserializer(decoder: .init())
      )
    ))
    dummyLocation = .init(
      name: "성신여대입구역 4호선",
      category: "교통,수송 > 지하철,전철 > 수도권4호선",
      roadAddress: "서울 성북구 동소문로 지하 102",
      coordinate: .init(
        latitude: 37.59296812939267,
        longitude: 127.0171260607647
      )!
    )
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    
    sut = nil
    dummyData = nil
    dummyLocation = nil
  }
  
  func test_setCurrentLocation에_Location을전달하면_currentLocation은해당Location이다() {
    // given
    let expectation: Location = dummyLocation
    
    // when
    sut.setCurrentLocation(expectation)
    
    // then
    XCTAssertEqual(sut.currentLocation, expectation)
  }
  
  func test_currentLocation이nil일때_setCurrentLocation에nil을전달하면_currentLocation은nil이다() {
    // given
    let input: Location? = nil
    
    // when
    sut.setCurrentLocation(input)
    
    // then
    XCTAssertNil(sut.currentLocation)
  }
  
  func test_currentLocation이dummyLocation일때_setCurrentLocation에nil을전달하면_currentLocation은nil이다() {
    // given
    let input: Location? = nil
    
    // when
    sut.setCurrentLocation(input)
    
    // then
    XCTAssertNil(sut.currentLocation)
  }
  
  func test_isDisplaySearchResult가true일때_closeSearchResult시_isDisplaySearchResult는false다() {
    // given
    sut.isDisplaySearchResult = true
    
    // when
    sut.closeSearchResult()
    
    // then
    XCTAssertFalse(sut.isDisplaySearchResult)
  }
  
  func test_isDisplaySearchResult가false일때_closeSearchResult시_isDisplaySearchResult는false다() {
    // given
    sut.isDisplaySearchResult = false
    
    // when
    sut.closeSearchResult()
    
    // then
    XCTAssertFalse(sut.isDisplaySearchResult)
  }
  
  func test_searchButtonAction시_isDisplaySearchResult는true_searchedLocations는올바른값이된다() async {
    // given
    let expectation: [Location] = [dummyLocation]
    sut.setCurrentLocation(dummyLocation)
    
    // when
    await sut.searchButtonAction(keyword: "성신역")
    
    // then
    XCTAssertTrue(sut.isDisplaySearchResult)
    XCTAssertEqual(sut.searchedLocations, expectation)
  }
  
  func test_searchButtonAction시_keyword를입력하지않으면_isDisplaySearchResult는false_searchedLocation은빈배열이다() async {
    // given
    let expectation: [Location] = []
    sut.setCurrentLocation(dummyLocation)
    
    // when
    await sut.searchButtonAction(keyword: "")
    
    // then
    XCTAssertFalse(sut.isDisplaySearchResult)
    XCTAssertEqual(sut.searchedLocations, expectation)
  }
  
  func test_searchButtonAction시_keyword를입력하지않으면_searchedLocation이있어도_isDisplaySearchResult는false_searchedLocation은빈배열이다() async {
    // given
    let expectation: [Location] = []
    sut.setCurrentLocation(dummyLocation)
    await sut.searchButtonAction(keyword: "성신역")
    sut.closeSearchResult()
    
    // when
    await sut.searchButtonAction(keyword: "")
    
    // then
    XCTAssertFalse(sut.isDisplaySearchResult)
    XCTAssertEqual(sut.searchedLocations, expectation)
  }
  
  func test_올바른좌표에서searchSubwayStation시_middleLocation은해당지하철역이된다() async {
    // given
    let expectation: Location = dummyLocation
    sut.setCurrentLocation(dummyLocation)
    
    // when
    await sut.searchSubwayStation(at: .init(
      latitude: 37.59296812939267,
      longitude: 127.0171260607647
    ))
    
    // then
    XCTAssertEqual(sut.middleLocation, expectation)
  }
}
