//
//  AppDelegate.swift
//  TouchFaceID
//
//  Created by Mahmoud Sherbeny on 30/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        self.window?.rootViewController = NoteVC()
        self.window?.makeKeyAndVisible()
        return true
    }
}

