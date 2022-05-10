//
//  TestModel.swift
//  Zemoga
//
//  Created by Miguel Angel Saravia Belmonte on 5/10/22.
//

import Foundation

// MARK: - TestModel
struct TestModel: Codable {
    let userID: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
