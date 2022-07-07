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
    override var root: Presentable {
        return router.toPresentable()
    }

    init(userManager: UserManager, router: Router) {
        super.init(router: router, navigationType: .newFlow(hideBar: true))
        bindDeeplink()
        
        setLogin() // fixed for testing
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
        let loginCoordinator = LoginCoordinator(router: router, navigationType: .newFlow(hideBar: false))
        loginCoordinator.coordinatorStepper
            .filter { if case .homeRequired = $0 { return true } else { return false } }
            .subscribe(coordinatorStepper)
            .store(in: &disposeBag)
        
        setRootChild(coordinator: loginCoordinator, hideBar: false)
    }
    
    override func bindStepper() {
        super.bindStepper()
        
        coordinatorStepper.receive(on: DispatchQueue.main)
            .sink { [weak self] step in
                switch step {
                case .homeRequired:
                    self?.setHome()
                case .loginRequired:
                    self?.setLogin()
                default:
                    break
                }
            }.store(in: &disposeBag)
    }
}
