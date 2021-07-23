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

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    private var loginButtonPressed = true
    private var mail = ""
    private var pass = ""
    private var checkedRememberMe = false

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self

        loginButton.layer.cornerRadius = 17
        loginButton.layer.masksToBounds = true
    }

    @IBAction func rememberMeButton(_ sender: UIButton) {

        if !checkedRememberMe {
            checkBox.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
            checkedRememberMe = true
        } else {
            checkBox.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
            checkedRememberMe = false
        }
    }

    func initializing() {
        mail = emailTextField.text ?? ""
        pass = passwordTextField.text ?? ""
    }

    func endTextFieldEditing() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
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

        /// Networking
        if emailTextField.text != "" && passwordTextField.text != "" {
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

private extension LoginViewController {

    func networking(email: String, password: String) {

        SVProgressHUD.show()

        let params: [String: String] = [
            "email": mail,
            "password": pass,
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
