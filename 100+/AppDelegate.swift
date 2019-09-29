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
        setupRootViewController()
        return true
    }
    
    func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)

        if let _ = HealthDataBaseManager().healthModel {
            let feedVC = UIStoryboard(storyboard: .feed).instantiateInitialViewController() as! FeedViewController
            let nVC = UINavigationController(rootViewController: feedVC)
            nVC.setNavigationBarHidden(true, animated: false)
            window?.rootViewController = nVC
        } else {
            let pollVC = UIStoryboard(storyboard: .main).instantiateInitialViewController() as! PollViewController
            let nVC = UINavigationController(rootViewController: pollVC)
            nVC.setNavigationBarHidden(true, animated: false)
            window?.rootViewController = nVC
        }
        
        window?.makeKeyAndVisible()
    }
    
    func configureNetworkLogger() {
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
    }

}

