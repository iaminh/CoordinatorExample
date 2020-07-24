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
        let navigationController =  UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Dashboard", image: nil, tag: 1)
        let router = Router(navigationController: navigationController)
        let coordinator = DashboardCoordinator(router: router, navigationType: .newFlow(hideBar: false))

        addChild(coordinator)

        return coordinator
    }()

    private lazy var settingsCoordinator: SettingsCoordinator = {
        let navigationController =  UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Settings", image: nil, tag: 2)
        let router = Router(navigationController: navigationController)
        let coordinator = SettingsCoordinator(router: router, navigationType: .newFlow(hideBar: false))

        addChild(coordinator)

        return coordinator
    }()

    private lazy var profileCoordinator: ProfileCoordinator = {
        let navigationController =  UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 3)
        let router = Router(navigationController: navigationController)
        let coordinator = ProfileCoordinator(router: router, navigationType: .newFlow(hideBar: false))

        addChild(coordinator)

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
        bindDeeplink()
    }

    private func bindDeeplink() {
        deeplinkSubject
            .unwrap()
            .map(HomeFlow.init(deeplink:))
            .unwrap()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] deeplink in
                guard let self = self else { return }
                switch deeplink {
                case .dashboard:
                    self.tabBarController.selectedViewController = self.dashboardCoordinator.toPresentable()
                case .profile:
                    self.tabBarController.selectedViewController = self.profileCoordinator.toPresentable()
                case .settings:
                    self.tabBarController.selectedViewController = self.settingsCoordinator.toPresentable()
                }
                self.resetDeeplink()
            }.store(in: &disposeBag)
    }

    private func setTabs() {
        tabs = [:]

        let vcs = [dashboardCoordinator, profileCoordinator, settingsCoordinator].map { coordinator -> UIViewController in
            let viewController = coordinator.toPresentable()
            tabs[viewController] = coordinator
            return viewController
        }

        tabBarController.setViewControllers(vcs, animated: false)
    }
}

