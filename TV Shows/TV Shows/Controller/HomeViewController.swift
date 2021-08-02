//
//  ShowsViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 23.07.2021..
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showsAllButton: UIButton!
    @IBOutlet weak var topRatedShowsButton: UIButton!
    
    var shows: [Show] = []
    private var notificationToken: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData(urlExtension: "/shows")
        
        notifications()
    }
    
    deinit {
        if let notificationToken = notificationToken {
            NotificationCenter.default.removeObserver(notificationToken)
        }
    }
}

// MARK: - IBActions

extension HomeViewController {
    
    @IBAction func showsButton(_ sender: UIButton) {
        showsAllButton.isSelected = true
        topRatedShowsButton.isSelected = false
        self.title = "Shows"
        fetchData(urlExtension: "/shows")
    }
    
    @IBAction func topShowsButton(_ sender: UIButton) {
        topRatedShowsButton.isSelected = true
        showsAllButton.isSelected = false
        self.title = "Top Rated"
        fetchData(urlExtension: "/shows/top_rated")
    }
    
    @IBAction func MyAccount(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: K.ViewControllers.MyAccountViewController, bundle: .main)
        let myAccountViewController = storyboard.instantiateViewController(withIdentifier: K.ViewControllers.MyAccountViewController) as! MyAccountViewController
        let navigationController = UINavigationController(
            rootViewController: myAccountViewController
        )
        self.present(navigationController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: K.Cell.HomeViewControllerCell, for: indexPath
        ) as! HomeTableViewCell
        cell.showImage.setImage(imageUrl: shows[indexPath.row].imageUrl)
        cell.showTitleLabel.text = shows[indexPath.row].title
        
        return cell
    }
}

// MARK: - class HomeTableViewCell: UITableViewCell

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = shows[indexPath.row]
        
        /// Transition - New ViewController & Storyboard
        let storyboard = UIStoryboard(name: K.ViewControllers.ShowDetailsViewController, bundle: .main)
        let showDetailsViewController = storyboard.instantiateViewController(
            withIdentifier: K.ViewControllers.ShowDetailsViewController) as! ShowDetailsViewController
        showDetailsViewController.show = show
        navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
}

// MARK: - Notifications

extension HomeViewController {
    
    func notifications() {
        notificationToken = NotificationCenter
            .default
            .addObserver(
                forName: K.Notifications.notificationName,
                object: nil,
                queue: nil
            ) {
                [weak self] notification in
                guard let self = self else { return }
                let storyboard = UIStoryboard(name: K.ViewControllers.LoginViewController, bundle: nil)
                let loginViewController = storyboard.instantiateViewController(
                    withIdentifier: K.ViewControllers.LoginViewController) as! LoginViewController
                self.navigationController?.setViewControllers([loginViewController], animated: true)
            }
    }
}
