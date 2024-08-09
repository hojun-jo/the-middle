//
//  NavigationBar.swift
//  TheMiddle
//
//  Created by 조호준 on 8/9/24.
//

import SwiftUI

struct NavigationBar<Left: View, Center: View, Right: View>: View {
  @ScaledMetric private var height: Double = 32
  
  private let leftItem: Left
  private let centerItem: Center
  private let rightItem: Right
  
  init(
    leftItem: Left = box,
    centerItem: Center = box,
    rightItem: Right = box
  ) {
    self.leftItem = leftItem
    self.centerItem = centerItem
    self.rightItem = rightItem
  }
  
  var body: some View {
    VStack {
      HStack {
        leftItem
          .frame(
            width: height,
            height: height
          )
        
        Spacer()
        
        centerItem
          .frame(height: height)
        
        Spacer()
        
        rightItem
          .frame(
            width: height,
            height: height
          )
      }
      .padding()
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
  NavigationBar()
}

private let box = Rectangle()
  .foregroundStyle(.white)
