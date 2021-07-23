//
//  Users.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import Foundation

struct Users: Codable {
    let user: User
}

struct User: Codable {
    let id: String
    let email: String
    let imageUrl: String?
//    let password: String
//    let passwordConfirmation: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case imageUrl = "image_url"
//        case password
//        case passwordConfirmation = "password_confirmation"
    }
}

//struct LoginData: Codable {
//    let token: String
//}

