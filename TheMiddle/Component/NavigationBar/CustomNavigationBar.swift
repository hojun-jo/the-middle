//
//  CustomNavigationBar.swift
//  TheMiddle
//
//  Created by 조호준 on 3/26/24.
//

import SwiftUI

struct CustomNavigationBar: View {
  @State private var placeName: String
  
  private let leftButtonAction: () -> Void
  private let rightButtonAction: (String) -> Void
  private let isSearchMode: Bool
  
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
    VStack {
      HStack {
        Button(
          action: leftButtonAction,
          label: { Image(systemName: "arrow.left") }
        )
        .padding()
        
        Spacer()
        
        if isSearchMode {
          TextField(
            "장소, 버스, 지하철, 주소 검색",
            text: $placeName
          )
          .padding(.horizontal, 5)
          .autocorrectionDisabled()
          .textFieldStyle(.roundedBorder)
          
          Button(
            action: { rightButtonAction(placeName) },
            label: { Image(systemName: "magnifyingglass") }
          )
          .padding()
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
      .padding(.horizontal)
      .foregroundStyle(.black)
      .fontWeight(.bold)
      
      Rectangle()
        .frame(height: 1)
        .opacity(0.1)
    }
    .background(.white)
  }
}

#Preview {
  CustomNavigationBar(placeName: .init(initialValue: "장소 검색"))
}
