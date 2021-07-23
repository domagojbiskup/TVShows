//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import UIKit
import SVProgressHUD
import Alamofire

final class HomeViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    private var loginButtonPressed = true
    private var mail = ""
    private var pass = ""
    private var rePass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        APIService.shared.login()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    func initializing() {
        mail = emailTextField.text ?? ""
        pass = passwordTextField.text ?? ""
        rePass = repeatPasswordTextField.text ?? ""
    }
    
    func endTextFieldEditing() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        repeatPasswordTextField.endEditing(true)
    }
    
    func textFieldChackerAndNetworking() {
        /// Email checker
        if emailTextField.text == "" {
            emailTextField.placeholder = "Enter your email!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.emailTextField.placeholder = "Email"
            }
        }
        /// Password checker
        if passwordTextField.text == "" {
            passwordTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.passwordTextField.placeholder = "New password"
            }
        }
        ///
        if repeatPasswordTextField.text != passwordTextField.text {
            passwordTextField.text = ""
            repeatPasswordTextField.text = ""
            repeatPasswordTextField.placeholder = "Password is not same!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.repeatPasswordTextField.placeholder = "Repeat password"
            }
        }
        /// Networking
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text == passwordTextField.text {
            networking(email: mail, password: pass)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endTextFieldEditing()
        return true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Login" {
            loginButtonPressed = true
        } else if sender.titleLabel?.text == "Register" {
            loginButtonPressed = false
        } else {
            print("loginButtonPressed errored out")
        }
        
        endTextFieldEditing()
        initializing()
        textFieldChackerAndNetworking()
    }
}

private extension HomeViewController {
    
    func networking(email: String, password: String) {
        
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": mail,
            "password": pass,
            "password_confirmation": pass
        ]
        
        AF
            .request(
                url(loginButtonPressed),
                method: .post,
                parameters: params,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: Users.self) { response in
                switch response.result {
                case .success(let response):
                    print("Success: \(response.user.email)")
                    SVProgressHUD.dismiss()
                case .failure (let error):
                    print("Failure: \(error)")
                    SVProgressHUD.dismiss()
                }
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
