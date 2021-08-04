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

// MARK: - Networking

private let headers = authCheck()?.headers ?? [:]

private func authCheck() -> AuthInfo? {
    if AuthStorage.load() != nil {
        return AuthStorage.load()
    } else {
        return SessionManager.shared.authInfo
    }
}

// MARK: - LoginViewController

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
                K.API.baseUrl + urlExtension,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success/*(let response)*/:
                    //                    print("Success: \(response.user.email)")
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    let authInfo = try? AuthInfo(headers: headers)
                    SessionManager.shared.authInfo = authInfo
                    self.rememberMeChecked(authInfo)
                    SVProgressHUD.dismiss()
                    self.transitionToHomeViewController()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                    self.popupAlert()
                }
            }
    }
}

// MARK: - HomeViewController

extension HomeViewController {
    
    func fetchData (_ showsCurrentPage: Int, urlExtension: String) {
        activityIndicator.startAnimating()
        
        AF
            .request(
                K.API.baseUrl + urlExtension,
                method: .get,
                parameters: ["page": "\(showsCurrentPage)", "items": "20"],
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ShowsResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success(let response):
                    //                    print("Success: \(response)")
                    self.showsCurrentPage = response.meta.pagination.page
                    self.showsPagesNumber = response.meta.pagination.pages
                    self.shows.append(contentsOf: response.shows)
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                    self.activityIndicator.stopAnimating()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                    self.activityIndicator.stopAnimating()
                }
            }
    }
}

// MARK: - ShowDetailsViewController

extension ShowDetailsViewController {
    
    func fetchData(_ reviewsCurrentPage: Int, urlExtension: String) {
        if fetchInProgress { return }
        activityIndicator.startAnimating()
        
        fetchInProgress = true
        AF
            .request(
                K.API.baseUrl + urlExtension,
                method: .get,
                parameters: ["page": "\(reviewsCurrentPage)", "items": "20"],
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ReviewsResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                self.fetchInProgress = false
                switch dataResponse.result {
                case .success(let response):
                    //                    print("Success: \(response)")
                    self.reviewsCurrentPage = response.meta.pagination.page
                    self.reviewsPagesNumber = response.meta.pagination.pages
                    self.reviews.append(contentsOf: response.reviews)
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                    self.activityIndicator.stopAnimating()
                case .failure(let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                    self.activityIndicator.stopAnimating()
                }
            }
    }
}

// MARK: - WriteAReviewViewController

extension WriteAReviewViewController {
    
    func pushData(comment: String, rating: String, showId: String, urlExtension: String) {
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "comment": comment,
            "rating": rating,
            "show_id": showId
        ]
        
        AF
            .request(
                K.API.baseUrl + urlExtension,
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default,
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: ReviewResponse.self) { [weak self] dataResponse in
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

// MARK: - MyAccountViewController

extension MyAccountViewController {
    
    func fetchData(urlExtension: String) {
        SVProgressHUD.show()
        
        AF
            .request(
                K.API.baseUrl + urlExtension,
                method: .get,
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success(let response):
                    //                    print("Success: \(response.user.email)")
                    self.emailLabel.text = response.user.email
                    if !(response.user.imageUrl?.isEmpty ?? true) {
                        self.profilePhoto.setImage(imageUrl: response.user.imageUrl ?? "")
                    }
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
    
    func uploadImage(_ image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.9) else { return }
        
        let requestData = MultipartFormData()
        requestData.append(
            imageData,
            withName: "image",
            fileName: "image.jpeg",
            mimeType: "image/jpeg"
        )
        
        AF
            .upload(
                multipartFormData: requestData,
                to: "https://tv-shows.infinum.academy/users",
                method: .put,
                headers: HTTPHeaders(headers)
            )
            .validate()
            .responseDecodable(of: UsersResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                switch dataResponse.result {
                case .success:
                    self.fetchData(urlExtension: "/users/me")
                    SVProgressHUD.dismiss()
                case .failure(let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
            }
    }
}


