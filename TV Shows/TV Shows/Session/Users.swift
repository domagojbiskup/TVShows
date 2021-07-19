//
//  Users.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import Foundation

struct Users: Codable {
    let Users: User
}

struct User: Codable {
    let email: String
    let password: String
    let passwordConfirmation: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case passwordConfirmation = "password_confirmation"
    }
}
