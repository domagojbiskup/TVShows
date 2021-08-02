//
//  Shows.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import Foundation

struct ShowsResponse: Decodable {
    let shows: [Show]
    let meta: Meta

}

struct Show: Decodable {
    let id: String
    let title: String
    let imageUrl: String
    let description: String?
    let noOfReviews: Int
    let averageRating: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case imageUrl = "image_url"
        case averageRating = "average_rating"
        case noOfReviews = "no_of_reviews"
    }
}

struct Meta: Codable {
    let pagination: Pagination
}

struct Pagination: Codable {
    let count, page, items, pages: Int
}
