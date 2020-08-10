//
//  MainAppDelegate.swift
//  App
//
//  Created by Alex Shipin on 09.08.2020.
//  Copyright © 2020 Alexander Shipin. All rights reserved.
//

import UIKit
import Core

open class MainAppDelegate: UIResponder, UIApplicationDelegate
{

    public var window: UIWindow?

    private let app = App()

    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {

        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UINavigationController()
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        self.window = window
        self.app.run(in: rootVC)
        return true
    }

}
