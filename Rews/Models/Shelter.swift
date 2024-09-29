//
//  Shelter.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 21/09/24.
//

struct Shelter: Codable, Identifiable {
    let id: Int
    let name, address, phone: String
    let latitude, longitude: Double
    let description, createdAt: String
}

struct SheltersMainTown: Codable {
    let latitude, longitude: String
}
