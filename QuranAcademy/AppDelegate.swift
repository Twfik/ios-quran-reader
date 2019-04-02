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
        UISwitch.appearance().onTintColor = #colorLiteral(red: 0.262745098, green: 0.3176470588, blue: 0.2196078431, alpha: 1)
        setupRootViewController()
        setupNavigationBar()
        registerUserDefaults()
    }
    
    private func setupRootViewController() {
        let rootController = ContainerViewController(nibName: nil, bundle: nil)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
    
    private func setupNavigationBar() {
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.8431372549, alpha: 1)
        UINavigationBar.appearance().isTranslucent = false
    }
    
    private func registerUserDefaults() {
        UserDefaults.standard.register(defaults: [
            Keys.kArabicFontSize : 17,
            Keys.kTranslationFontSize : 17,
            Keys.kArabicEnable : true,
            Keys.kTranslateEnable : true,
            Keys.kArabicFont: "me_quran2",
            Keys.kTranslationFont: "Proxima Nova"
            ])
    }

}

