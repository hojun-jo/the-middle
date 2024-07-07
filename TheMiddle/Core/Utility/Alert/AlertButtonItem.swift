//
//  AlertButtonItem.swift
//  TheMiddle
//
//  Created by 조호준 on 7/6/24.
//

import Foundation

struct AlertButtonItem {
  var action: () -> Void
  var text: String
}

extension AlertButtonItem: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(text)
  }
  
  static func == (
    lhs: AlertButtonItem,
    rhs: AlertButtonItem
  ) -> Bool {
    return lhs.text == rhs.text
  }
}
