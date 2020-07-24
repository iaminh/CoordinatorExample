//
//  CardCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/24/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

class CardCoordinator: Coordinator {
    private lazy var rootVC = CardViewController()

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
            .map(CardFlow.init(deeplink:))
            .unwrap()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] deeplink in
                guard let self = self else { return }
                switch deeplink {
                case .cardDetail:
                    self.showCardDetail()
                }
                self.resetDeeplink()
            }.store(in: &disposeBag)
    }

    private func showCardDetail() {
        router.push(CardDetailViewController())
    }
}
