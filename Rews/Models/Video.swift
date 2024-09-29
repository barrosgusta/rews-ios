//
//  Video.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 21/09/24.
//

struct Video: Codable, Identifiable {
    let id: Int
    let title, description, youtubeVideoId, createdAt: String
}
