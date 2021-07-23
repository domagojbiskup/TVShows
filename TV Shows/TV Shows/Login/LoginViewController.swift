//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit
import SVProgressHUD
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordEyeButton: UIButton!
    @IBOutlet private weak var checkBoxRememberMeButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var email = ""
    private var password = ""
    private var passwordEyeActive = false
    private var checkedRememberMe = false
    private var loginButtonPressed = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = 17
        loginButton.layer.masksToBounds = true
    }
    
    @IBAction func passwordEyeButton(_ sender: UIButton) {
        
        if passwordEyeActive {
            passwordEyeButton.setImage(UIImage(named: "ic-visible"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        } else {
            passwordEyeButton.setImage(UIImage(named: "ic-invisible"), for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
        passwordEyeActive.toggle()
    }
    
    @IBAction func rememberMeButton(_ sender: UIButton) {
        
        if checkedRememberMe {
            checkBoxRememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            checkBoxRememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
        }
        checkedRememberMe.toggle()
    }
    
    func initializing() {
        email = emailTextField.text ?? ""
        password = passwordTextField.text ?? ""
    }
    
    func endTextFieldEditing() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldChackerAndNetworking() {
        
        /// Email checker
        if emailTextField.text == "" {
            emailTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.emailTextField.placeholder = "Email"
            }
        }
        
        /// Password checker
        if passwordTextField.text == "" {
            passwordTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.passwordTextField.placeholder = "Password"
            }
        }
        
        /// Networking
        if emailTextField.text != "" && passwordTextField.text != "" {
            networking(email: email, password: password)
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

private extension LoginViewController {
    
    func networking(email: String, password: String) {
        
        SVProgressHUD.show()
        
        let params: [String: String] = [
            "email": email,
            "password": password,
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


