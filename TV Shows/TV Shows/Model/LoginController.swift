//
//  LoginController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 24.07.2021..
//

import UIKit

extension LoginViewController {
    
    func loginController() {
        if loginSuccessful ?? false {
            performSegue(withIdentifier: "goToShows", sender: self)
        } else {
            popupAlert()
        }
    }
    
    func popupAlert() {
        let alert = UIAlertController(title: "Login/Register Failure",
                                      message: "Wrong account information or trying to register existing user. Please try again.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),
                                      style: .default, handler: { _ in
                                        NSLog("The \"OK\" alert occured.")
                                      }))
        self.present(alert, animated: true, completion: nil)
    }
}
