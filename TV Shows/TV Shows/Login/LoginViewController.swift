//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var checkBox: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var checked = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        
//        SVProgressHUD.show()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            SVProgressHUD.dismiss()
//        }
    }

    @IBAction func rememberMeButton(_ sender: UIButton) {
                
        if !checked {
            checkBox.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
            checked = true
        } else {
            checkBox.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
            checked = false
        }
    }
}
