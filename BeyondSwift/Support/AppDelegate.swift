//
//  AppDelegate.swift
//  BeyondSwift
//
//  Created by Leonardo Geus on 20/08/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var dependencyRegistry: DependencyRegistry!
    static var navigationCoordinator: NavigationCoordinator!
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
