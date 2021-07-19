//
//  HomeViewController.swift
//  TV Shows
//
//  Created by Infinum Infinum on 16.07.2021..
//

import Foundation
import UIKit

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        APIService.shared.login()
    }
}
