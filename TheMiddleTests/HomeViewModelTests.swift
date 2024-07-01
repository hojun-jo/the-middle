//
//  HomeViewModelTests.swift
//  TheMiddleTests
//
//  Created by 조호준 on 7/1/24.
//

import XCTest
@testable import TheMiddle

@MainActor
final class HomeViewModelTests: XCTestCase {
  var sut: HomeViewModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = .init(startLocations: dummyLocations)
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    
    sut = nil
  }
  
  func test_출발지역의좌표가모두0이면_averageCoordinate시_좌표가0이다() {
    // given
    // when
    let result: Coordinate? = sut.averageCoordinate()
    
    // then
    XCTAssertEqual(result?.latitude, 0)
    XCTAssertEqual(result?.longitude, 0)
  }
  
  func test_출발지역이없으면_averageCoordinate시_nil을리턴한다() {
    // given
    sut.startLocations = []
    
    // when
    let result: Coordinate? = sut.averageCoordinate()
    
    // then
    XCTAssertNil(result)
  }
  
  func test_changeOrAddLocation에_origin이있으면_해당인덱스의Location이new로변경된다() {
    // given
    let index: Int = dummyLocations.count - 1
    let origin: Location = dummyLocations.last!
    let new: Location = .init(
      name: "0",
      category: "0",
      roadAddress: "0",
      coordinate: .init(
        latitude: 0,
        longitude: 0
      )!
    )
    
    // when
    sut.changeOrAddLocation(origin: origin, new: new)
    
    // then
    XCTAssertEqual(sut.startLocations[index], new)
  }
  
  func test_changeOrAddLocation에_origin이없으면_startLocations에new가추가된다() {
    // given
    let new: Location = .init(
      name: "0",
      category: "0",
      roadAddress: "0",
      coordinate: .init(
        latitude: 0,
        longitude: 0
      )!
    )
    
    // when
    sut.changeOrAddLocation(origin: nil, new: new)
    
    // then
    XCTAssertEqual(sut.startLocations.count, dummyLocations.count + 1)
    XCTAssertEqual(sut.startLocations.last, new)
  }
  
  func test_removeLocation시_해당인덱스의Location이삭제된다() {
    // given
    let index: Int = 1
    let origin: Location = sut.startLocations[index]
    
    // when
    sut.removeLocation(at: index)
    
    // then
    XCTAssertEqual(sut.startLocations.count, dummyLocations.count - 1)
    XCTAssertNotEqual(sut.startLocations[index], origin)
  }
  
  func test_removeLocation시_startLocations의인덱스범위에서벗어나면_삭제가일어나지않는다() {
    // given
    let index: Int = sut.startLocations.count
    
    // when
    sut.removeLocation(at: index)
    
    // then
    XCTAssertEqual(sut.startLocations.count, dummyLocations.count)
  }
}
