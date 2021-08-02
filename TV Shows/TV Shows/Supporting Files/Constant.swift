//
//  Constant.swift
//  TV Shows
//
//  Created by Infinum Infinum on 01.08.2021..
//

import Foundation

struct K {
    /// ViewControllers
    static let LoginViewController = "LoginViewController"
    static let HomeViewController = "HomeViewController"
    static let MyAccountViewController = "MyAccountViewController"
    static let ShowDetailsViewController = "ShowDetailsViewController"
    static let WriteAReviewViewController = "WriteAReviewViewController"

    /// Cells
    static let ShowBasicInfoTableCell = "ShowBasicInfoTableCell"
    static let ShowReviewTableCell = "ShowReviewTableCell"
    
    /// Notifications
    static let notificationName = Notification.Name(rawValue: "didLogout")
    static let didLogout = Notification(name: notificationName)
    static let logout = "didLogout"
}
