//
//  CustomNavigationBar.swift
//  TheMiddle
//
//  Created by 조호준 on 3/26/24.
//

import SwiftUI

struct CustomNavigationBar: View {
  @State private var placeName: String
  
  let leftButtonAction: () -> Void
  let rightButtonAction: (String) -> Void
  let isSearchMode: Bool
  
  init(
    placeName: State<String> = .init(initialValue: ""),
    leftButtonAction: @escaping () -> Void = {},
    rightButtonAction: @escaping (String) -> Void = {_ in },
    isSearchMode: Bool = true
  ) {
    self._placeName = placeName
    self.leftButtonAction = leftButtonAction
    self.rightButtonAction = rightButtonAction
    self.isSearchMode = isSearchMode
  }
  
  var body: some View {
    HStack {
      Button(
        action: leftButtonAction,
        label: { Image(systemName: "arrow.left") }
      )
      .padding()
      .background(.red)
      
      Spacer()
      
      if isSearchMode {
        TextField(
          "장소, 버스, 지하철, 주소 검색",
          text: $placeName
        )
        .padding(.horizontal)
        .autocorrectionDisabled()
        .textFieldStyle(.roundedBorder)
        .background(.blue)
        
        Button(
          action: { rightButtonAction(placeName) },
          label: { Image(systemName: "magnifyingglass") }
        )
        .padding()
        .background(.green)
      } else {
        Text("중간 위치 검색 결과")
        
        Spacer()
        
        Button(
          action: {},
          label: { Image(systemName: "magnifyingglass") }
        )
        .padding()
        .hidden()
      }
    }
    .padding()
    .foregroundStyle(.black)
    .fontWeight(.bold)
    .background(.gray)
  }
}

#Preview {
  CustomNavigationBar(placeName: .init(initialValue: "장소 검색"))
}
