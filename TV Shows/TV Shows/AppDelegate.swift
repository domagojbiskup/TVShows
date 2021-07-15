//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Infinum Infinum on 08.07.2021..
//

import UIKit
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

/*
        let myInt: Int = 2
         
        let params: [String: String] =  [
            "email": "dbiskup@foi.hr",
            "password": "",
            "password_conformation": ""
        ]
*/
/*
        AF
            .request(
                "https://tv-shows.infinum.academy/users",
//                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self)
*/
//            .responseJSON(completionHandler: { response in
//                switch response.result {
//                case .success (let body):
//                    print("Success: \(body)")
//                case .failure(let error):
//                    print("Error: \(error)")
//                }
//            })

        return true
    }
}
