//
//  Article.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 12/09/24.
//

import Foundation

struct Article: Codable, Identifiable {
    let id: Int
    let title, content, publishedAt: String
    let authorID: Int
    let author: User

    enum CodingKeys: String, CodingKey {
        case id, title, content, publishedAt
        case authorID = "authorId"
        case author
    }
}
