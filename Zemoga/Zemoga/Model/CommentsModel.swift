//
//  CommentsModel.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/5/22.
//

import Foundation

// MARK: - CommentsModel
struct CommentsModel: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
