//
//  User.swift
//  TV Shows
//
//  Created by Infinum Infinum on 14.07.2021..
//

struct UserResponse: Decodable {
    let user: User
}

struct User: Decodable {
    let id: String
    let mail: String
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id
        case mail = "email"
        case imageUrl = "image_url"
    }
}

