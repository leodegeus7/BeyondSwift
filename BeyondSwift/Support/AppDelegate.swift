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

    func applicationDidFinishLaunching(_ application: UIApplication) {
        let controller =
        ReactViewController.init(nibName: "ReactView", bundle: Bundle(for: AppDelegate.self))

        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)

        window!.rootViewController = controller
        window!.makeKeyAndVisible()

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
