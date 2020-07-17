//
//  AppDelegate.swift
//  CoordinatorExample
//
//  Created by Chu Anh Minh on 6/25/20.
//  Copyright © 2020 MinhChu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let appNavigationController = UINavigationController()
    private lazy var appRouter = Router(navigationController: self.appNavigationController)
    private lazy var appCoordinator = AppCoordinator(userState: .loggedOut, router: appRouter)
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
     
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = appCoordinator.toPresentable()
        window?.makeKeyAndVisible()
        return true
    }
}

