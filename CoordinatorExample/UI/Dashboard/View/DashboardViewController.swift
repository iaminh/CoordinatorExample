//
//  DashboardViewController.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var onShowCardTapped: (() -> Void)? = nil

    @IBAction func showCardTapped(_ sender: Any) {
        onShowCardTapped?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dashboard"
        view.backgroundColor = .blue
    }
}
