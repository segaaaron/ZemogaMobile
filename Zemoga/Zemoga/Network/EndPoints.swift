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
    case users
    case comments(id: Int)
    
    var endpoint: String {
        switch self {
        case .posts:
            return "/posts"
        case .users:
            return "/users"
        case .comments(let id):
            return "/posts/\(id)/comments"
        }
    }
}
