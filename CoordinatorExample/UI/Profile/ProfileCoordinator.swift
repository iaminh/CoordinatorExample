//
//  ProfileCoordinator.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

class ProfileCoordinator: Coordinator {
    private let rootVC = ProfileViewController()

    override var root: Presentable {
        return rootVC
    }
}
