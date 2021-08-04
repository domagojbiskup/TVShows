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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData(urlExtension: "/shows")
    }
    
    @IBAction func showsButton(_ sender: UIButton) {
        showsAllButton.isSelected = true
        topRatedShowsButton.isSelected = false
        fetchData(urlExtension: "/shows")
    }
    
    @IBAction func topShowsButton(_ sender: UIButton) {
        topRatedShowsButton.isSelected = true
        showsAllButton.isSelected = false
        fetchData(urlExtension: "/shows/top_rated")
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ShowsVCCell.self), for: indexPath
        ) as! ShowsVCCell
        cell.showImage.setImage(imageUrl: shows[indexPath.row].imageUrl)
        cell.showTitle.text = shows[indexPath.row].title
        
        return cell
    }
}

class ShowsVCCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = shows[indexPath.row]
        
        let storyboard = UIStoryboard(name: "ShowDetails", bundle: .main)
        let showViewController = storyboard.instantiateViewController(withIdentifier: "ShowDetailsVC") as! ShowDetailsVC
        
        showViewController.show = show
        navigationController?.pushViewController(showViewController, animated: true)
    }
}
