//
//  AppDelegate.swift
//  100+
//
//  Created by Dzianis Baidan on 27/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureNetworkLogger()
        return true
    }
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CameraViewController()
        window?.makeKeyAndVisible()
    }
    
    func configureNetworkLogger() {
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
    }

}

