//
//  HomeView.swift
//  TheMiddle
//
//  Created by 조호준 on 3/21/24.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var homeViewModel: HomeViewModel
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .center) {
        ScrollView(.vertical) {
          ForEach(homeViewModel.locations, id: \.self) { location in
            LocationButtonView(location: location.name)
          }
          LocationButtonView(location: "+")
        }
        .padding()
        
        Button(
          action: {
            // TODO: - 중간 지점 계산
          },
          label: {
            Image(systemName: "magnifyingglass")
              .renderingMode(.template)
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundStyle(.white)
          }
        )
        .padding()
        .frame(width: geometry.size.width)
        .background(.green)
      }
    }
  }
}

// MARK: - Location Button View
private struct LocationButtonView: View {
  private let location: String
  
  fileprivate init(location: String) {
    self.location = location
  }
  
  fileprivate var body: some View {
    GeometryReader { geometry in
      HStack {
        Spacer()
        
        Button(
          action: {
            // TODO: - 검색 페이지로 이동
          },
          label: {
            Text(location)
          }
        )
        .padding()
        .frame(width: geometry.size.width * 0.8)
        .font(.title)
        .background(.blue)
        .foregroundStyle(.white)
        .clipShape(.buttonBorder)
        
        Spacer()
      }
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(HomeViewModel())
}
