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
  let rightButtonAction: () -> Void
  let isSearchMode: Bool
  
  init(
    placename: State<String> = .init(initialValue: ""),
    leftButtonAction: @escaping () -> Void = {},
    rightButtonAction: @escaping () -> Void = {},
    isSearchMode: Bool = true
  ) {
    self._placeName = placename
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
      
      Spacer()
      
      if isSearchMode {
        TextField(
          "장소, 버스, 지하철, 주소 검색",
          text: $placeName
        )
        .padding(.horizontal)
        .autocorrectionDisabled()
        .textFieldStyle(.roundedBorder)
        
        Button(
          action: rightButtonAction,
          label: { Image(systemName: "magnifyingglass") }
        )
      }
    }
    .padding()
    .foregroundStyle(.black)
    .fontWeight(.bold)
  }
}

#Preview {
  CustomNavigationBar(placename: .init(initialValue: "장소 검색"))
}
