//
//  PostModel.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/4/22.
//

import Foundation

// MARK: - PostModel
struct PostModel: Codable {
    let userID: Int
    let id: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
