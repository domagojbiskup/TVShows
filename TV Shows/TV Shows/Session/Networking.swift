//
//  Networking.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import Foundation
import Alamofire

private var regUrl = "https://tv-shows.infinum.academy/users"
private var loginUrl = "https://tv-shows.infinum.academy/users/sign_in"

var users: Users?



class APIService {
    
    private init() {}
    
    static let shared: APIService = APIService()
    
    static func register() {
        AF.request(regUrl, method: .post).responseDecodable(of: Users.self) {
            response in
            users = response.value
        }
    }

    func login() {
        AF.request(loginUrl, method: .post).responseDecodable(of: Users.self) {
            response in
            users = response.value
        }
    }
}
