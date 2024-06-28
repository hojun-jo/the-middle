//
//  KakaoLocationDTO.swift
//  TheMiddle
//
//  Created by 조호준 on 3/22/24.
//

struct KakaoLocationDTO: Codable, Equatable {
  let documents: [KakaoLocationItem]
}

struct KakaoLocationItem: Codable, Equatable {
  let addressName: String
  let categoryGroupCode: String
  let categoryGroupName: String
  let categoryName: String
  let distance: String
  let id: String
  let phone: String
  let placeName: String
  let placeUrl: String
  let roadAddressName: String
  let longitude: String
  let latitude: String
  
  enum CodingKeys: String, CodingKey {
    case addressName = "address_name"
    case categoryGroupCode = "category_group_code"
    case categoryGroupName = "category_group_name"
    case categoryName = "category_name"
    case distance
    case id
    case phone
    case placeName = "place_name"
    case placeUrl = "place_url"
    case roadAddressName = "road_address_name"
    case longitude = "x"
    case latitude = "y"
  }
}
