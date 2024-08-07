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
  var alertButtons: [AlertButtonItem] { get set }
}

extension AlertDisplayable {
  func displayAlert(
    message: AlertMessage,
    buttons: [AlertButtonItem] = [
      .init(
        action: {},
        text: "확인"
      )
    ]
  ) {
    setAlertMessage(message.description)
    setIsDisplayAlert(true)
    setButtons(buttons)
  }
  
  private func setAlertMessage(_ message: String) {
    alertMessage = message
  }
  
  private func setIsDisplayAlert(_ isDisplay: Bool) {
    isDisplayAlert = isDisplay
  }
  
  private func setButtons(_ buttons: [AlertButtonItem]) {
    alertButtons = buttons
  }
}
