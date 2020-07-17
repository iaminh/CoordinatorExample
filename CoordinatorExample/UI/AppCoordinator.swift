//
//  AppCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 6/25/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

enum UserState {
    case loggedIn
    case loggedOut
}

class AppCoordinator: Coordinator {
    private var userState: UserState

    override var root: Presentable {
        switch userState {
        case .loggedOut:
            return LoginCoordinator(router: router, navigationType: .currentFlow)
        case .loggedIn:
            return DashboardCoordinator(router: router, navigationType: .currentFlow)
        }
    }

    init(userState: UserState, router: Router) {
        self.userState = userState

        super.init(router: router, navigationType: .newFlow(hideBar: true))
    }
}
