//
//  LoginCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation
import Combine

class LoginCoordinator: Coordinator {
    private let userManager: UserManager

    private lazy var loginVC: LoginViewController = {
        let vc = LoginViewController()
        vc.onLoginTap = { [weak self] in self?.userManager.userState = .loggedIn }
        vc.onRegisterTap = { [weak self] in self?.showRegistration() }

        return vc
    }()

    init(router: Router, navigationType: Coordinator.NavigationType, userManager: UserManager) {
        self.userManager = userManager
        super.init(router: router, navigationType: navigationType)
    }

    private func showRegistration() {
        router.push(RegistrationViewController())
    }
    
    override var root: Presentable {
        return loginVC
    }
}
