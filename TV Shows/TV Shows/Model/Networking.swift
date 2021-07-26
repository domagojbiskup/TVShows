//
//  Networking.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import Foundation
import SVProgressHUD
import Alamofire

extension LoginViewController {
    
    func networking(email: String, password: String) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        AF
            .request(
                url(loginButtonPressed ?? true),
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) {
                response in
                switch response.result {
                case .success(let userResponse):
                    print("Success: \(userResponse.user.email)")
                    self.loginSuccessful = true
                    SVProgressHUD.dismiss()
                    let headers = response.response?.headers.dictionary ?? [:]
                    let authInfo = try? AuthInfo(headers: headers)
                    SessionManager.shared.authInfo = authInfo
                case .failure (let error):
                    print("Failure: \(error)")
                    self.loginSuccessful = false
                    SVProgressHUD.dismiss()
                }
                self.loginController()
            }
    }
    
    func url(_ loginButtonPressed: Bool) -> String {
        let loginUrl = "https://tv-shows.infinum.academy/users/sign_in"
        let regUrl = "https://tv-shows.infinum.academy/users"
        
        if loginButtonPressed {
            return loginUrl
        } else if !loginButtonPressed {
            return regUrl
        } else {
            return "loginButtonPressed errored out"
        }
    }
}

extension HomeViewController {
    
    func networking () {
        SVProgressHUD.show()
        
        let url = "https://tv-shows.infinum.academy/shows"
        let headers = SessionManager.shared.authInfo?.headers ?? [:]
        
        AF
            .request(
                url,
                method: .get,
                parameters: ["page": "1", "items": "100"],
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self) {
                [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let response):
                    print("Success: \(response)")
                    self?.showsResponse = response
                    self?.tableView.reloadData()
                    SVProgressHUD.dismiss()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}
