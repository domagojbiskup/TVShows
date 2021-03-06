//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailLineLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordEyeButton: UIButton!
    @IBOutlet private weak var passwordLineLabel: UILabel!
    @IBOutlet private weak var checkBoxRememberMeButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAwayDissmissKeyboard)
        )
        self.view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func rememberMeChecked(_ authInfo: AuthInfo?) {
        if checkBoxRememberMeButton.isSelected {
            AuthStorage.store(authInfo)
        }
    }
    
    func transitionToHomeViewController() {
        let storyboard = UIStoryboard(name: K.ViewControllers.HomeViewController, bundle: .main)
        let homeViewController = storyboard.instantiateViewController(
            withIdentifier: K.ViewControllers.HomeViewController) as! HomeViewController
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

// MARK: - IBActions

extension LoginViewController {
    
    @IBAction func passwordEyeButton(_ sender: UIButton) {
        if !passwordEyeButton.isSelected {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
        passwordEyeButton.isSelected.toggle()
    }
    
    @IBAction func rememberMeButton(_ sender: UIButton) {
        checkBoxRememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .selected)
        checkBoxRememberMeButton.isSelected.toggle()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(urlExtension: "/users/sign_in")
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        endTextFieldEditing()
        textFieldChackerAndNetworking(urlExtension: "/users")
    }
}

// MARK: - TextField Checker & networking

extension LoginViewController {
    
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
            shake(object: self.emailLineLabel)
            emailTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.emailTextField.placeholder = "Email"
            }
        }
        
        /// Password checker
        if isPasswordEmpty {
            shake(object: self.passwordTextField)
            shake(object: self.passwordEyeButton)
            shake(object: self.passwordLineLabel)
            passwordTextField.placeholder = "This field cannot be empty!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                self.passwordTextField.placeholder = "Password"
            }
        } else if passwordTextField.text?.count ?? 0 < 6 {
            shake(object: self.passwordTextField)
            shake(object: self.passwordEyeButton)
            shake(object: self.passwordLineLabel)
            passwordTextField.text = ""
            passwordTextField.placeholder = "Must be at least 6 characters long!"
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
}

// MARK: - Keyboard Functions

extension LoginViewController: UITextFieldDelegate {
    
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
    
    @objc func tapAwayDissmissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Keyboard Layout Auto-Slider
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        let keyboardHeight = keyboardFrame.size.height
        if keyboardHeight < 200 {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

// MARK: - PopUp Alert

extension LoginViewController {
    
    func popupAlert() {
        let alert = UIAlertController(
            title: "Login/Register Failure",
            message: "Wrong account information or trying to register existing user. Please try again.",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default,
                handler: { _ in
                    #if DEBUG
                    print("The \"OK\" alert occured.")
                    #endif
                }
            )
        )
        present(alert, animated: true, completion: nil)
    }
}
