//
//  NetworkManagerTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/30/24.
//

import XCTest
@testable import TheMiddle

final class NetworkManagerTests: XCTestCase {
  var sut: NetworkManager!
  var dummy: Data!
  var api: KakaoLocationAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    dummy = try JSONEncoder().encode(dummyKakaoLocation)
    sut = NetworkManager(session: StubNetworkSession(
      dummy: dummy,
      response: HTTPURLResponse()
    ))
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
  
  func test_KakaoLocationAPI에올바른키워드와위경도를입력하면_fetchData시_올바른데이터를리턴한다() async throws {
    // given
    // when
    let result: Data = try await sut.fetchData(api)
    
    // then
    XCTAssertEqual(result, dummy)
  }
  
  func test_response의statusCode가실패면_fetchData시_badStatusCode에러를던진다() async {
    // given
    sut = NetworkManager(session: StubNetworkSession(
      dummy: dummy,
      response: HTTPURLResponse(
        url: .init(string: "https://dapi.kakao.com/v2/local/search/keyword.json")!,
        statusCode: 500,
        httpVersion: nil,
        headerFields: nil
      )!
    ))
    
    do {
      // when
      let result: Data = try await sut.fetchData(api)
    } catch {
      // then
      XCTAssertEqual(error.localizedDescription, "500 네트워크 오류입니다.")
    }
  }
  
  func test_response가HTTPResponse가아니면_fetchData시_invalidResponse에러를던진다() async {
    // given
    sut = NetworkManager(session: StubNetworkSession(
      dummy: dummy,
      response: URLResponse()
    ))
    
    do {
      // when
      let result: Data = try await sut.fetchData(api)
    } catch {
      // then
      XCTAssertEqual(error.localizedDescription, "네트워크 응답이 잘못되었습니다.")
    }
  }
}
