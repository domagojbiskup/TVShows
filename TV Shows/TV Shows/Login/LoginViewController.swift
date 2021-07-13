//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 09.07.2021..
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var clickCounterLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var buttonTapCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SVProgressHUD.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            SVProgressHUD.dismiss()
        }
        
        activityIndicator.startAnimating()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
        }
    }

    @IBAction func plusOneButton(_ sender: Any) {
        clickCounterLabel.text = "\(buttonTapCount)"
        buttonTapCount += 1
    }
}
