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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = 17
        loginButton.layer.masksToBounds = true
    }
    
    @IBAction func passwordEyeButton(_ sender: UIButton) {
        if !passwordEyeButton.isSelected {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
        passwordEyeButton.isSelected.toggle()
    }
    
    @IBAction func rememberMeButton(_ sender: UIButton) {
        checkBoxRememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        checkBoxRememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .selected)
        checkBoxRememberMeButton.isSelected.toggle()
    }
    
    func endTextFieldEditing() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldChackerAndNetworking(url: String) {
        let isEmailEmpty = emailTextField.text?.isEmpty ?? true
        let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        /// Email checker
        if isEmailEmpty {
            emailTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.emailTextField.placeholder = "Email"
            }
        }
        
        /// Password checker
        if isPasswordEmpty {
            passwordTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.passwordTextField.placeholder = "Password"
            }
        }
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            networking(email: email, password: password, url: url
            )
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endTextFieldEditing()
        return true
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(url: "https://tv-shows.infinum.academy/users/sign_in")
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(url: "https://tv-shows.infinum.academy/users")
    }
}
