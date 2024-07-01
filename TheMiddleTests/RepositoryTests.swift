//
//  RepositoryTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 7/1/24.
//

import XCTest
@testable import TheMiddle

final class RepositoryTests: XCTestCase {
  var sut: Repository!
  var dummy: Data!
  var api: KakaoLocationAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    dummy = try JSONEncoder().encode(dummyKakaoLocation)
    sut = Repository(
      networkManager: .init(session: StubNetworkSession(
        dummy: dummy,
        response: HTTPURLResponse()
      )),
      deserializer: JSONNetworkDeserializer(decoder: .init())
    )
    api = try .init(
      keyword: "성신역",
      latitude: "37.59296812939267",
      longitude: "127.0171260607647"
    )!
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    
    sut = nil
    dummy = nil
    api = nil
  }
  
  func test_올바른키워드와위경도를입력하면_fetchLocation시_올바른Location배열을리턴한다() async throws {
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
    let result: [Location] = try await sut.fetchLocations(
      keyword: "성신역",
      latitude: "37.59296812939267",
      longitude: "127.0171260607647"
    )
    
    // then
    XCTAssertEqual(result, expectation)
  }
}
