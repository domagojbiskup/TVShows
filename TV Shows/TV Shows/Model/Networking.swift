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
    
    func networking(email: String, password: String, url: String) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        AF
            .request(
                url,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let userResponse):
                    print("Success: \(userResponse.user.email)")
                    SVProgressHUD.dismiss()
                    let headers = response.response?.headers.dictionary ?? [:]
                    let authInfo = try? AuthInfo(headers: headers)
                    SessionManager.shared.authInfo = authInfo
                    self.performSegue(withIdentifier: "goToShows", sender: self)
                case .failure (let error):
                    print("Failure: \(error)")
                    self.popupAlert()
                    SVProgressHUD.dismiss()
                }
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
