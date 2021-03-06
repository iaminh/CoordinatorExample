//
//  DashboardCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

class DashboardCoordinator: Coordinator {
    private lazy var rootVC: DashboardViewController = {
        let vc = DashboardViewController()
        vc.onShowCardTapped = { [weak self] in
            self?.showCard()
        }

        return vc
    }()

    override var root: Presentable {
        return rootVC
    }

    override init(router: Router, navigationType: Coordinator.NavigationType) {
        super.init(router: router, navigationType: navigationType)
        bindDeeplink()
    }

    private func bindDeeplink() {
        deeplinkSubject
            .unwrap()
            .map(DashboardFlow.init(deeplink:))
            .unwrap()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] deeplink in
                guard let self = self else { return }
                switch deeplink {
                case .card:
                    self.showCard(animated: false)
                }
                self.resetDeeplink()
            }.store(in: &disposeBag)
    }

    private func showCard(animated: Bool = true) {
        let cardCoordinator = CardCoordinator(router: router, navigationType: .currentFlow)
        pushChild(coordinator: cardCoordinator, animated: animated)
    }
}
