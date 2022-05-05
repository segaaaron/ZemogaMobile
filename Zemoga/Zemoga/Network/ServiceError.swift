//
//  ServiceError.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation

protocol ErrorService {
    associatedtype FailureResponseType
    static func handleError(_ error: NSError?, failure: FailureResponseType)
}
final class ServiceError: ErrorService {
    typealias FailureResponseType = (_ error: NSError?) -> Void
    
    static func handleError(_ error: NSError?, failure: FailureResponseType) {
        if let e = error {
            switch e.code {
            case NSURLErrorTimedOut:
                failure(NSError(domain: "", code: -1001, userInfo: ["msg": "Time exceeded error"]))
            case NSURLErrorNetworkConnectionLost:
                failure(NSError(domain: "", code: -1005, userInfo: ["msg": "You do not have an Internet connection"]))
            case NSURLErrorNotConnectedToInternet:
                failure(NSError(domain: "", code: -1009, userInfo: ["msg": "The Internet connection appears to be offline"]))
            default:
                failure(NSError(domain: "", code: 500, userInfo: ["msg": "Unexpected error"]))
            }
        } else {
            failure(NSError(domain: "", code: 500, userInfo: ["msg": "Unexpected error"]))
        }
    }
}

