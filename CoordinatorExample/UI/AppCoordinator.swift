//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 6/25/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit
import Combine

enum UserState {
    case loggedIn
    case loggedOut
}

class AppCoordinator: Coordinator {
    private let userManager: UserManager

    override var root: Presentable {
        return router.toPresentable()
    }

    init(userManager: UserManager, router: Router) {
        self.userManager = userManager
        super.init(router: router, navigationType: .newFlow(hideBar: true))

        bindUserState()
        bindDeeplink()
    }

    private func bindUserState() {
        userManager.$userState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userState in
                self?.refreshRoot(userState: userState)
            }.store(in: &disposeBag)
    }

    private func refreshRoot(userState: UserState) {
        switch userState {
        case .loggedOut:
            setLogin()
        case .loggedIn:
            setHome()
        }
    }

    private func bindDeeplink() {
        deeplinkSubject
            .unwrap()
            .map(AppFlow.init(deeplink:))
            .unwrap()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] deeplink in
                guard let self = self else { return }
                switch deeplink {
                case .home:
                    self.setHome()
                case .login:
                    self.setLogin()
                }
                self.resetDeeplink()
            }.store(in: &disposeBag)
    }

    private func setHome() {
        let homeCoordinator = HomeCoordinator(router: router, navigationType: .newFlow(hideBar: true))
        setRootChild(coordinator: homeCoordinator, hideBar: true)
    }

    private func setLogin() {
        let loginCoordinator = LoginCoordinator(router: router, navigationType: .newFlow(hideBar: false), userManager: userManager)
        setRootChild(coordinator: loginCoordinator, hideBar: false)
    }
}
