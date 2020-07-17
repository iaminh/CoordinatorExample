//
//  DashboardCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

class DashboardCoordinator: Coordinator {
    private let rootVC = DashboardViewController()

    override var root: Presentable {
        return rootVC
    }
}
