//
//  AppDelegate.swift
//  LD Swift News
//
//  Created by Gaurav Parvadiya on 04/10/19.
//  Copyright © 2019 Gaurav Parvadiya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       let _window = UIWindow(frame: UIScreen.main.bounds)
        window = _window

       let _appCoordinator = AppCoordinator(window: window!)
       appCoordinator = _appCoordinator
       appCoordinator.start()

        return true
    }
}

