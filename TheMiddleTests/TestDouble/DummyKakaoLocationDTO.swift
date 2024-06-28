//
//  DummyKakaoLocationDTO.swift
//  TheMiddleTests
//
//  Created by 조호준 on 6/28/24.
//

@testable import TheMiddle

let dummyKakaoLocation: KakaoLocationDTO = .init(documents: [
  KakaoLocationItem(
    addressName: "서울 성북구 동선동4가 1",
    categoryGroupCode: "SW8",
    categoryGroupName: "지하철역",
    categoryName: "교통,수송 > 지하철,전철 > 수도권4호선",
    distance: "0",
    id: "21160600",
    phone: "02-6110-4181",
    placeName: "성신여대입구역 4호선",
    placeUrl: "http://place.map.kakao.com/21160600",
    roadAddressName: "서울 성북구 동소문로 지하 102",
    longitude: "127.0171260607647",
    latitude: "37.59296812939267"
  )
])
