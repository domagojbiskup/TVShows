//
//  Users.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import Foundation

struct UsersResponse: Codable {
    let user: User
}

struct User: Codable {
    let id: String
    let email: String
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case imageUrl = "image_url"
    }
}

//struct LoginData: Codable {
//    let token: String
//}

