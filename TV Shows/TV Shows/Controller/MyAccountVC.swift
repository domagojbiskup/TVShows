//
//  MyAccountVC.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class MyAccountVC: UIViewController {
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var changePhotoButton: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.text = eMail
        
        logoutButton.layer.cornerRadius = 20
        logoutButton.layer.masksToBounds = true
    }
    
    @IBAction func unwindMyAccount(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
    }
}
