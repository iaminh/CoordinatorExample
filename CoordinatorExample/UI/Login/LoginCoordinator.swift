//
//  LoginCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

class LoginCoordinator: Coordinator {
    private let rootVC = LoginViewController()

    override var root: Presentable {
        return rootVC
    }
}
