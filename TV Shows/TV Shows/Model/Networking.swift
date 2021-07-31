//
//  Networking.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import Foundation
import Alamofire
import Kingfisher
import SVProgressHUD

private let baseUrl = "https://tv-shows.infinum.academy"
private let headers = authCheck()?.headers ?? [:]

private func authCheck() -> AuthInfo? {
    if AuthStorage.load() != nil {
        return AuthStorage.load()
    } else {
        return AuthTempStorage.storage.authInfo
    }
}

extension LoginViewController {
    
    func pushData(email: String, password: String, urlExtension: String) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]
        
        AF
            .request(
                baseUrl + urlExtension,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) {
                [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success/*(let response)*/:
                    //                    print("Success: \(response.user.email)")
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    let authInfo = try? AuthInfo(headers: headers)
                    AuthTempStorage.storage.authInfo = authInfo
                    self.rememberMeChecked(authInfo)
                    SVProgressHUD.dismiss()
                    self.transitionToHomeVC()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                    self.popupAlert()
                }
            }
    }
}

extension HomeViewController {
    
    func fetchData (urlExtension: String) {
        SVProgressHUD.show()
        
        AF
            .request(
                baseUrl + urlExtension,
                method: .get,
                parameters: ["page": "1", "items": "100"],
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self) {
                [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success(let response):
                    //                    print("Success: \(response)")
                    self.shows = response.shows
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}

extension ShowDetailsVC {
    
    func fetchData(urlExtension: String) {
        SVProgressHUD.show()
        
        AF
            .request(
                baseUrl + urlExtension,
                method: .get,
                parameters: ["page": "1", "items": "100"],
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ReviewsResponse.self) {
                [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success(let response):
                    //                    print("Success: \(response)")
                    self.reviews = response.reviews
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}

extension WriteAReviewVC {
    
    func pushData(comment: String, rating: String, showId: String, urlExtension: String) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "comment": comment,
            "rating": rating,
            "show_id": showId
        ]
        
        AF
            .request(
                baseUrl + urlExtension,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default,
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ReviewResponse.self) {
                [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success/*(let response)*/:
                    //                    print("Success: \(response)")
                    self.delegate?.reloadData()
                    self.dismiss(animated: true, completion: nil)
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
