//
//  TVShowTableViewCell.swift
//  TableView
//
//  Created by Infinum Infinum on 19.07.2021..
//

import UIKit

class TVShowTableViewCell: UITableViewCell {

    @IBOutlet private var showNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with showName: String) {
        showNameLabel.text = showName
    }
}
