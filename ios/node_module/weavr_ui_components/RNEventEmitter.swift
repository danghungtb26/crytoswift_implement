//
//  RNEventEmitter.swift
//  CocoaAsyncSocket
//
//  Created by Tareq Islam on 5/12/22.
//
import Foundation
import React

@objc(RNEventEmitter)
open class RNEventEmitter: RCTEventEmitter {

  public static var emitter: RCTEventEmitter!

  override init() {
    super.init()
    RNEventEmitter.emitter = self
  }

  open override func supportedEvents() -> [String] {
    ["onKycCompleteFailed", "onKycCompleteSuccessful", "onFailure", "onEvent", "onKycFailed","onStatusChanged", "onKycSdkTerminate", "onKycException", "onTokenExpired", "onKycActionComplete"]      // etc.
  }
}
