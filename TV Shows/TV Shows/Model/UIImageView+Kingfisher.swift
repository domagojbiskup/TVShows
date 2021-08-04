//
//  UIImageView+Kingfisher.swift
//  TV Shows
//
//  Created by Infinum Infinum on 02.08.2021..
//

import UIKit

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
