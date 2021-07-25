//
//  ShowsResponse.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import Foundation

struct ShowsResponse: Decodable {
    let shows: [Show]
}

struct Show: Decodable {
    let id: String
    let title: String
    let description: String?
    let imageUrl: String
    let averageRating: String?
    let noOfReviews: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl = "image_url"
        case averageRating = "average_rating"
        case noOfReviews = "no_of_reviews"
    }
}
