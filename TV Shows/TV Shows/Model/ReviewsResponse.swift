//
//  Reviews.swift
//  TV Shows
//
//  Created by Infinum Infinum on 28.07.2021..
//

import Foundation

struct ReviewsResponse: Codable {
    let reviews: [Review]
}

struct ReviewResponse: Codable {
    let review: Review
}

struct Review: Codable {
    let id: String
    let comment: String
    let rating: Int
    let showId: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case rating
        case comment
        case showId = "show_id"
        case user
    }
}
