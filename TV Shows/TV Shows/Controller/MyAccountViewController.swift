//
//  MyAccountViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class MyAccountViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData(urlExtension: "/users/me")
        
        profilePhoto.layer.borderWidth = 3
        profilePhoto.layer.masksToBounds = false
        profilePhoto.layer.borderColor = #colorLiteral(red: 0.3215686275, green: 0.2117647059, blue: 0.5490196078, alpha: 1)
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height/2
        profilePhoto.clipsToBounds = true
        profilePhoto.contentMode = .scaleAspectFill
        
        logoutButton.layer.cornerRadius = 20
        logoutButton.layer.masksToBounds = true
    }
}

// MARK: - IBActions

extension MyAccountViewController {
    @IBAction func changeProfilePhotoButtonPressed(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        dismiss(animated: true) {
            AuthStorage.clear()
            SessionManager.shared.authInfo = nil
            NotificationCenter.default.post(K.Notifications.didLogout)
        }
    }
}

// MARK: - ImagePicker

extension MyAccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        
        uploadImage(image)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
