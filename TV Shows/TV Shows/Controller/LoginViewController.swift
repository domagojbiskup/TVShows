//
//  LoginViewController.swift
//  TV Home
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailLine: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordEyeButton: UIButton!
    @IBOutlet private weak var passwordLine: UILabel!
    @IBOutlet private weak var checkBoxRememberMeButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = 20
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
    
    func rememberMeChecked(_ authInfo: AuthInfo?) {
        if checkBoxRememberMeButton.isSelected {
            AuthStorage.store(authInfo)
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(urlExtension: "/users/sign_in")
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(urlExtension: "/users")
    }

    func endTextFieldEditing() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endTextFieldEditing()
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endTextFieldEditing()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldChackerAndNetworking(urlExtension: String) {
        let isEmailEmpty = emailTextField.text?.isEmpty ?? true
        let isPasswordEmpty = passwordTextField.text?.isEmpty ?? true
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        /// Email checker
        if isEmailEmpty {
            shake(object: self.emailTextField)
            shake(object: self.emailLine)
            emailTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.emailTextField.placeholder = "Email"
            }
        }
        
        /// Password checker
        if isPasswordEmpty {
            shake(object: self.passwordTextField)
            shake(object: self.passwordEyeButton)
            shake(object: self.passwordLine)
            passwordTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.passwordTextField.placeholder = "Password"
            }
        }
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            pushData(email: email, password: password, urlExtension: urlExtension)
        }
    }

    func shake(object: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: object.center.x - 5, y: object.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: object.center.x + 5, y: object.center.y))
        object.layer.add(animation, forKey: "position")
    }
    
    func transitionToHomeVC() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
