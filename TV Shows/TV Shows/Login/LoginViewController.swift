//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    var buttonPressed = 1

    @IBOutlet weak var clickCounterLabel: UILabel!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ActivityIndicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (_) in
            self.ActivityIndicator.stopAnimating()
        }
    }

    @IBAction func plusOneButton(_ sender: Any) {
        clickCounterLabel.text = "\(buttonPressed)"
        buttonPressed += 1
    }
}
