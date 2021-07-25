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
                case .success(let response):
                    print("Success: \(response.user.email)")
                    self.loginSuccessful = true
                    SVProgressHUD.dismiss()
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

extension Shows {
    
    func networking () {
        SVProgressHUD.show()
        
        let url = "https://tv-shows.infinum.academy/shows"
        
//        let headers = [
//            "Accept": acceptt,
//            "access-token": accessToken,
//            "client": client,
//            "token-type": tokenType,
//            "expiry": expiry,
//            "uid": uid,
//            "Content-Type": contentType
//        ]
        
        AF
            .request(
                url,
                method: .get,
                parameters: ["page": "1", "items": "100"]/*,
                headers: HTTPHeaders(authInfo.headers)*/) // MARK:- kak ovaj headers rijesit
            .validate()
            .responseDecodable(of: ShowsResponse.self) {
                [weak self] response in
                switch response.result {
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
/*
 .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
     switch dataResponse.result {
     case .success(let userResponse):
         let headers = dataResponse.response?.headers.dictionary ?? [:]
         self?.handleSuccesfulLogin(for: userResponse.user, headers: headers)
     case .failure(let error):
         self?._infoLabel.text = "API/Serialization failure: \(error)"
         SVProgressHUD.showError(withStatus: "Failure")
     }
 }
}

// Headers will be used for subsequent authorization on next requests
func handleSuccesfulLogin(for user: User, headers: [String: String]) {
guard let authInfo = try? AuthInfo(headers: headers) else {
 _infoLabel.text = "Missing headers"
 SVProgressHUD.showError(withStatus: "Missing headers")
 return
}
_infoLabel.text = "User: \(user), authInfo: \(authInfo)"
SVProgressHUD.showSuccess(withStatus: "Success")
}
 */
