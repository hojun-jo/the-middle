//
//  NavigationBackButton.swift
//  TheMiddle
//
//  Created by 조호준 on 8/9/24.
//

import SwiftUI

struct NavigationBackButton: View {
  private let action: () -> Void
  
  init(_ action: @escaping () -> Void) {
    self.action = action
  }
  
  var body: some View {
    Button(
      action: action,
      label: {
        Image(systemName: ImageNamespace.leftArrow)
      }
    )
    .accessibilityLabel(.init(UtilityNamespace.back))
  }
}

#Preview {
  NavigationBackButton({})
}
