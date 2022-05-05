//
//  RequestService.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation

final class Request: NSObject {
    var url: String?
    var params: [String: String]? = nil
    var timeout: TimeInterval?
    var method: HTTPMethod = .GET
    var endPointPath: String?
}

final class RequestService: NSObject {
    static func getRequest(with requestModel: Request) -> URLRequest? {
        guard let pathUrl = requestModel.url,
              let endPoint = requestModel.endPointPath,
              let timeOut = requestModel.timeout,
              var component = URLComponents(string: pathUrl + endPoint),
              let paramString = requestModel.params else { return nil }
        
        if requestModel.method == .GET {
            component.queryItems = paramString.map {(key, value) in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let currentUrl = component.url else { return nil }
        var request = URLRequest(url: currentUrl)
        
        if requestModel.method != .GET {
            if let paramsData = requestModel.params {
                let jsonData = try? JSONSerialization.data(withJSONObject: paramsData)
                request.httpBody = jsonData
            }
        }
        
        request.httpMethod = requestModel.method.rawValue
        request.timeoutInterval = timeOut
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
