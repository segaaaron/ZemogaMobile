//
//  EndPoints.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation

enum HTTPMethod: String {
    case GET = "get"
    case POST = "post"
    case PUT = "put"
}

enum EndPoints {
    case posts
    
    var endpoint: String {
        switch self {
        case .posts:
            return "/posts"
        }
    }
}
