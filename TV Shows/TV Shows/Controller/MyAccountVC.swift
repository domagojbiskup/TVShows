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
    @IBOutlet weak var changeProfilePhotoButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
                
        logoutButton.layer.cornerRadius = 20
        logoutButton.layer.masksToBounds = true
    }
    
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
    }
}
