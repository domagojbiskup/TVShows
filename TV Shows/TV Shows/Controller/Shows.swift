//
//  Shows.swift
//  TV Shows
//
//  Created by Infinum Infinum on 23.07.2021..
//

import UIKit

class Shows: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var showsResponse: ShowsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension Shows: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension Shows: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "show", for: indexPath)
        
        return cell
    }
}
