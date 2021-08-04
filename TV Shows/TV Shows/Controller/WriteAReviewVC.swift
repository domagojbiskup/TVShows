//
//  WriteAReviewViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

protocol ReloadData: AnyObject {
    func reloadData()
}

import UIKit

class WriteAReviewViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var rating = 0
    var showId: String?
    weak var delegate: ReloadData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.masksToBounds = true

        comment.delegate = self
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        reviewChecker()

        guard
            let comment = comment.text,
            let showId = showId
        else { return }

        if !comment.isEmpty && rating != 0 {
            pushData(comment: "\(comment)", rating: "\(rating)", showId: showId, urlExtension: "/reviews")
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        comment.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        comment.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func reviewChecker() {
        let isCommentEmpty = comment.text?.isEmpty ?? true
        
        if isCommentEmpty {
            comment.placeholder = "Type Something!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.comment.placeholder = "Enter your comment here..."
            }
        }
        
        if rating == 0 {
            selectRating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                selectRating()
            }
        }
        
        func selectRating() {
            self.star1.isSelected = true
            self.star2.isSelected = true
            self.star3.isSelected = true
            self.star4.isSelected = true
            self.star5.isSelected = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.star1.isSelected = false
                self.star2.isSelected = false
                self.star3.isSelected = false
                self.star4.isSelected = false
                self.star5.isSelected = false
            }
        }
    }

    @IBAction func star1Button(_ sender: UIButton) {
        star2.isSelected = false
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        star1.isSelected = true
        rating = 1
    }

    @IBAction func star2Button(_ sender: UIButton) {
        star3.isSelected = false
        star4.isSelected = false
        star5.isSelected = false
        star1.isSelected = true
        star2.isSelected = true
        rating = 2
    }

    @IBAction func star3Button(_ sender: UIButton) {
        star4.isSelected = false
        star5.isSelected = false
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        rating = 3
    }

    @IBAction func star4Button(_ sender: UIButton) {
        star5.isSelected = false
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        rating = 4
    }

    @IBAction func star5Button(_ sender: UIButton) {
        star1.isSelected = true
        star2.isSelected = true
        star3.isSelected = true
        star4.isSelected = true
        star5.isSelected = true
        rating = 5
    }
}
