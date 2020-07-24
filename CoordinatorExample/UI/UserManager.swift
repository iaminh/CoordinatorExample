//
//  UserManager.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/17/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation
import Combine

class UserManager {
    @Published var userState: UserState = .loggedOut
}
