//
//  Errors.swift
//  ReactNative


import Foundation

enum ErrorType {
    static let Failed = "Failed"
    static let Canceled = "Canceled"
    static let Unknown = "Unknown"
}

class Errors {
    class func createError (_ code: String, _ message: String?) -> NSDictionary {
        let value: NSDictionary = [
            "code": code,
            "message": message ?? NSNull(),
            "weavrErrorCode": NSNull(),
        ]
        
        return ["error": value]
    }
}
