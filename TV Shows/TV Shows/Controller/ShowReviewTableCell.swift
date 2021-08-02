//
//  ShowReviewTableCell.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class ShowReviewTableCell: UITableViewCell {

    @IBOutlet weak var reviewerProfileImage: UIImageView!
    @IBOutlet weak var reviewerEmailLabel: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var reviewLabel: UILabel!
     
    func rating(rating: Int) {
        switch rating {
        case 0:
            star1.isSelected = false
            
        case 1:
            star1.isSelected = true
            
        case 2:
            star1.isSelected = true
            star2.isSelected = true
            
        case 3:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            
        case 4:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            
        case 5:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            star5.isSelected = true
            
        default:
            fatalError()
        }
    }
}
