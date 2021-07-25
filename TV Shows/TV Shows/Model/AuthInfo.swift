//
//  AuthInfo.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import Foundation

struct AuthInfo: Codable {
    let acceptt: String
    let accessToken: String
    let client: String
    let tokenType: String
    let expiry: String
    let uid: String
    let contentType: String
    
    enum CodingKeys: String, CodingKey {
        case acceptt = "Accept"
        case accessToken = "access-token"
        case client
        case tokenType = "token-type"
        case expiry
        case uid
        case contentType = "Content-Type"
    }
}

