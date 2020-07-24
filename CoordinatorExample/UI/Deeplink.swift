//
//  Deeplink.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 7/24/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import Foundation

enum AppFlow: String {
    case home
    case login

    init?(deeplink: String) {
        if let flow = AppFlow(rawValue: deeplink) {
            self = flow
            return
        }

        if HomeFlow(deeplink: deeplink) != nil {
            self = .home
        } else if LoginFlow(deeplink: deeplink) != nil {
            self = .login
        } else {
            return nil
        }
    }
}

enum HomeFlow: String {
    case dashboard
    case profile
    case settings

    init?(deeplink: String) {
        if let flow = HomeFlow(rawValue: deeplink) {
            self = flow
            return
        }

        if DashboardFlow(deeplink: deeplink) != nil {
            self = .dashboard
        } else if ProfileFlow(deeplink: deeplink) != nil {
            self = .profile
        } else if SettingsFlow(deeplink: deeplink) != nil {
            self = .settings
        } else {
            return nil
        }
    }
}

enum DashboardFlow: String {
    case card

    init?(deeplink: String) {
        if let flow = DashboardFlow(rawValue: deeplink) {
            self = flow
            return
        }

        if CardFlow(deeplink: deeplink) != nil {
            self = .card
        } else {
            return nil
        }
    }
}

enum LoginFlow: String {
    case login
    case registration

    init?(deeplink: String) {
        if let flow = LoginFlow(rawValue: deeplink) {
            self = flow
        } else {
            return nil
        }
    }
}

enum ProfileFlow: String {
    case profile
    case editProfile

    init?(deeplink: String) {
        if let flow = ProfileFlow(rawValue: deeplink) {
            self = flow
        } else {
            return nil
        }
    }
}

enum SettingsFlow: String {
    case settings
    case pinsSettings

    init?(deeplink: String) {
        if let flow = SettingsFlow(rawValue: deeplink) {
            self = flow
        } else {
            return nil
        }
    }
}

enum CardFlow: String {
    case cardDetail

    init?(deeplink: String) {
        if let flow = CardFlow(rawValue: deeplink) {
            self = flow
        } else {
            return nil
        }
    }
}
