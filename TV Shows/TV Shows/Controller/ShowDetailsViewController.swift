//
//  ShowDetailsViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 27.07.2021..
//

import UIKit

class ShowDetailsViewController: UIViewController {
    
    @IBOutlet weak var showTitle: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var writeAReviewButton: UIButton!
    
    var show: Show?
    var user: User?
    var reviews: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3215686275, green: 0.2117647059, blue: 0.5490196078, alpha: 1)
        
        writeAReviewButton.layer.cornerRadius = 20
        writeAReviewButton.layer.masksToBounds = true
        
        tableView.dataSource = self
        fetchData(urlExtension: "/shows/\(show?.id ?? "")/reviews/")
        showTitle.title = show?.title
        
        self.tableView.register(UINib(nibName: K.Cell.ShowBasicInfoTableCell, bundle: nil),
                                forCellReuseIdentifier: String(describing: ShowBasicInfoTableCell.self))
        self.tableView.register(UINib(nibName: K.Cell.ShowReviewTableCell, bundle: nil),
                                forCellReuseIdentifier: String(describing: ShowReviewTableCell.self))
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self,
                                                 action: #selector(pullToRefresh),
                                                 for: .valueChanged)
    }
    
    @objc private func pullToRefresh() {
        fetchData(urlExtension: "/shows/\(show?.id ?? "")/reviews/")
        
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func WriteAReview(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: K.ViewControllers.WriteAReviewViewController, bundle: .main)
        let writeAReviewViewController = storyboard.instantiateViewController(
            withIdentifier: K.ViewControllers.WriteAReviewViewController)
            as! WriteAReviewViewController
        
        writeAReviewViewController.showId = show?.id
        writeAReviewViewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: writeAReviewViewController)
        self.present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ShowDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let titleCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowBasicInfoTableCell.self), for: indexPath
            ) as! ShowBasicInfoTableCell
            
            titleCell.showImage.setImage(imageUrl: show?.imageUrl ?? "")
            titleCell.showDescriptionLabel.text = show?.description
            titleCell.numOfReviewsLabel.text = "\(show?.noOfReviews ?? 0)"
            titleCell.averageNumberLabel.text = "\(show?.averageRating ?? 0)"
            titleCell.rating(rating: show?.averageRating ?? 0)
            titleCell.noReviewsYet(noOfRevs: show?.noOfReviews ?? 0)
            
            return titleCell
        } else {
            let reviewCell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: ShowReviewTableCell.self), for: indexPath
            ) as! ShowReviewTableCell
            
            let review = reviews[indexPath.row - 1]
            reviewCell.reviewerProfileImage.setImage(imageUrl: review.user.imageUrl ?? "")
            makeImageRounded(reviewCell.reviewerProfileImage)
            reviewCell.reviewerEmailLabel.text = review.user.email
            reviewCell.rating(rating: review.rating)
            reviewCell.reviewLabel.text = review.comment
            
            return reviewCell
        }
    }
    
    func makeImageRounded(_ profileImage: UIImageView) {
        profileImage.layer.borderWidth = 2
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = #colorLiteral(red: 0.3215686275, green: 0.2117647059, blue: 0.5490196078, alpha: 1)
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFill
    }
}

// MARK: - Delegate Pattern

extension ShowDetailsViewController: ReloadData {
    func reloadData() {
        fetchData(urlExtension: "/shows/\(show?.id ?? "")/reviews/")
    }
}
