//
//  KakaoLocationAPI.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

import Foundation

struct KakaoLocationAPI: APIType {
  let url: String = "https://dapi.kakao.com/v2/local/search/keyword.json"
  let headers: [String : String]?
  let queryItems: [URLQueryItem]? // TODO: - 추상화 필요 여부 판단
  
  init?(
    keyword: String,
    latitude: String? = nil,
    longitude: String? = nil
  ) throws {
    guard let kakaoAPIKey = Bundle.kakaoAPIKey else { throw APIError.invalidKey }
    
    self.headers = ["Authorization" : kakaoAPIKey]
    self.queryItems = [
      URLQueryItem(name: "query", value: keyword),
      URLQueryItem(name: "y", value: latitude),
      URLQueryItem(name: "x", value: longitude)
    ]
  }
}
