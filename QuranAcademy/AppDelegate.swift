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
        registerUserDefaults()
        Theme.current.apply()
    }
    
    private func setupRootViewController() {
        let rootController = ContainerViewController(nibName: nil, bundle: nil)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().isTranslucent = false
    }
    
    private func registerUserDefaults() {
        UserDefaults.standard.register(defaults: [
            Keys.kArabicFontSize : 17,
            Keys.kTranslationFontSize : 17,
            Keys.kArabicEnable : true,
            Keys.kTranslateEnable : true,
            Keys.kArabicFont: "me_quran",
            Keys.kTranslationFont: "Proxima Nova"
            ])
    }

}

