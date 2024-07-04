//
//  AlertDisplayable.swift
//  TheMiddle
//
//  Created by 조호준 on 5/10/24.
//

@MainActor
protocol AlertDisplayable: AnyObject {
  var isDisplayAlert: Bool { get set }
  var alertMessage: String { get set }
}

extension AlertDisplayable {
  func displayAlert(message: AlertMessage) {
    setErrorAlertMessage(message.description)
    setIsDisplayErrorAlert(true)
  }
  
  private func setErrorAlertMessage(_ message: String) {
    alertMessage = message
  }
  
  private func setIsDisplayErrorAlert(_ isDisplay: Bool) {
    isDisplayAlert = isDisplay
  }
}
