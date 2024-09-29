//
//  ServicePhone.swift
//  Rews
//
//  Created by Gustavo Barros da Silveira on 12/09/24.
//

import Foundation

struct ServicePhone: Codable, Identifiable {
    let id: Int
    let phone, description, createdAt: String
}
