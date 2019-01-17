//
//  AppDelegate.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        setup()
        return true
    }
    
    private func setup() {
        setupRootViewController()
        setupNavigationBar()
    }
    
    private func setupRootViewController() {
        let rootController = ContainerViewController(nibName: nil, bundle: nil)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationBar() {
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.1882352941, green: 0.4, blue: 0.6039215686, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

}

