//
//  AppDelegate.swift
//  VKCupTask1
//
//  Created by Артем Галай on 5.12.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = DragDropViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()

        return true
    }
}
