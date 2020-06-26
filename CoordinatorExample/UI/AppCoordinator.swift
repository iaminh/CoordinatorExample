//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 6/25/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    enum CoordinatorState {
        case login
        case registration
        case home
    }
    
    private lazy var rootVC: UIViewController = {
        let vc = UIViewController()
        vc.title = "Home"
        vc.view.backgroundColor = .red
        return vc
    }()
    
    override var root: Presentable {
        return rootVC
    }
}
