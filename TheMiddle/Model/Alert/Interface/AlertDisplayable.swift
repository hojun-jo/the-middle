//
//  AlertDisplayable.swift
//  TheMiddle
//
//  Created by 조호준 on 5/10/24.
//

import Foundation

@MainActor
protocol AlertDisplayable: AnyObject {
  // wrapped value
  var isDisplayAlert: Bool { get set }
  // published property wrapper
  var isDisplayAlertPublished: Published<Bool> { get }
  // publisher
  var isDisplayAlertPublisher: Published<Bool>.Publisher { get }
  
  var alertMessage: String { get set }
  var alertMessagePublished: Published<String> { get }
  var alertMessagePublisher: Published<String>.Publisher { get }
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
