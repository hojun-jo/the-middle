//
//  KakaoLocationAPI.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

struct KakaoLocationAPI: APIType {
  let url: String = "https://dapi.kakao.com/v2/local/search/keyword.json"
  let headers: [String : String]? = [
    "Authorization" : Bundle.kakaoAPIKey
  ]
  let queryItems: [URLQueryItem]?
  
  init(keyword: String, latitude: Double, longitude: Double) {
    self.queryItems = [
      URLQueryItem(name: "query", value: keyword),
      URLQueryItem(name: "y", value: String(latitude)),
      URLQueryItem(name: "x", value: String(longitude))
    ]
  }
}
