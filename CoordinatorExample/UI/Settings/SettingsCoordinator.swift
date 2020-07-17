//
//  SettingsCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

class SettingsCoordinator: Coordinator {
    private let rootVC = SettingsViewController()

    override var root: Presentable {
        return rootVC
    }
}
