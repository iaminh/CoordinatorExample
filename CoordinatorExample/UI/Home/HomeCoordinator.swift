//
//  HomeCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 6/26/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    private lazy var dashboardCoordinator: DashboardCoordinator = {
        let router = Router(navigationController: UINavigationController())
        let coordinator = DashboardCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        return coordinator
    }()

    private lazy var settingsCoordinator: SettingsCoordinator = {
        let router = Router(navigationController: UINavigationController())
        let coordinator = SettingsCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        return coordinator
    }()

    private lazy var profileCoordinator: ProfileCoordinator = {
        let router = Router(navigationController: UINavigationController())
        let coordinator = ProfileCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        return coordinator
    }()

    private let tabBarController: UITabBarController

    private var tabs: [UIViewController: Coordinator] = [:]

    override var root: Presentable {
        return tabBarController
    }

    override init(router: Router, navigationType: Coordinator.NavigationType) {
        self.tabBarController = UITabBarController()
        super.init(router: router, navigationType: navigationType)
        setTabs()
    }

    func setTabs() {
        tabs = [:]

        let vcs = [dashboardCoordinator, profileCoordinator, settingsCoordinator].map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            tabs[viewController] = coordinator
            return viewController
        }

        tabBarController.setViewControllers(vcs, animated: false)
    }
}

