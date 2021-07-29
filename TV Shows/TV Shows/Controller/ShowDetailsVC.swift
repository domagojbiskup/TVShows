//
//  ShowDetailsVC.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class ShowDetailsVC: UIViewController {
    
    @IBOutlet weak var showTitle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeAReview: UIButton!
    
    var show: Show?
    var user: User?
    var reviews: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        fetchData(urlExtension: "/shows/\(show?.id ?? "")/reviews/")
        showTitle.title = show?.title
        
        self.tableView.register(UINib(nibName: "ShowDetailsCell1", bundle: nil), forCellReuseIdentifier: String(describing: ShowDetailsCell1VC.self))
        self.tableView.register(UINib(nibName: "ShowDetailsCell2", bundle: nil), forCellReuseIdentifier: String(describing: ShowDetailsCell2VC.self))
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWriteAReview" {
            let navigationController = segue.destination as! UINavigationController
            let viewController = navigationController.viewControllers.first as! WriteAReviewVC
            viewController.showId = show?.id
            viewController.delegate = self
        }
    }
}

extension ShowDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let titleCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowDetailsCell1VC.self), for: indexPath
            ) as! ShowDetailsCell1VC

            titleCell.showImage.setImage(imageUrl: show?.imageUrl ?? "")
            titleCell.showDescription.text = show?.description
            titleCell.numOfReviews.text = "\(show?.noOfReviews ?? 0)"
            titleCell.averageNum.text = "\(show?.averageRating ?? 0)"
            titleCell.rating(rating: show?.averageRating ?? 0)
            titleCell.noReviewsYet(noOfRevs: show?.noOfReviews ?? 0)
            
            return titleCell
        } else {
            let reviewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowDetailsCell2VC.self), for: indexPath
            ) as! ShowDetailsCell2VC
            let review = reviews[indexPath.row - 1]
            reviewCell.reviewerProfilePhoto.setImage(imageUrl: review.user.imageUrl ?? "")
            reviewCell.reviewerEmail.text = review.user.email
            reviewCell.rating(rating: review.rating)
            reviewCell.review.text = review.comment
            
            return reviewCell
        }
    }
}

extension ShowDetailsVC: ReloadData {
    func reloadData() {
        fetchData(urlExtension: "/shows/\(show?.id ?? "")/reviews/")
    }
}
