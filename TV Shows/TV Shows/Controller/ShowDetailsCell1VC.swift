//
//  ShowDetailsCell1VC.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class ShowDetailsCell1VC: UITableViewCell {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var numOfReviews: UILabel!
    @IBOutlet weak var reviews: UILabel!
    @IBOutlet weak var averageNum: UILabel!
    @IBOutlet weak var average: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var noReviewsYet: UILabel!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
        
    func noReviewsYet(noOfRevs: Int) {
        if noOfRevs == 0 {
            numOfReviews.isHidden = true
            reviews.isHidden = true
            averageNum.isHidden = true
            average.isHidden = true
            view.isHidden = true
            noReviewsYet.isHidden = false
    }
}
    
    func rating(rating: Double) {
        switch rating {
        case 0:
            star1.isSelected = false
            
        case 0.1..<2:
            star1.isSelected = true
            
        case 2...2.5:
            star1.isSelected = true
            star2.isSelected = true
            
        case 2.5...3.5:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            
        case 3.5...4.5:
            star1.isSelected = true
            star2.isSelected = true
            star3.isSelected = true
            star4.isSelected = true
            
        case 4.5...5:
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
