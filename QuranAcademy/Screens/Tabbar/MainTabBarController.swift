//
//  TabBarController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

//MARK: - Setup
extension MainTabBarController {
    
    private func setup() {
        setupTabBar()
        setupFirstViewController()
        setupNavigationBar()
    }
    
    private func setupFirstViewController() {
           guard let surasViewController = children.first as? SurasViewController else { return }
        let viewModel = SurasViewModel()
        surasViewController.viewModel = viewModel
    }
    
    private func setupTabBar() {
        title = "Коран"
        tabBar.tintColor = #colorLiteral(red: 0.1882352941, green: 0.4, blue: 0.6039215686, alpha: 1)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.262745098, green: 0.3176470588, blue: 0.2196078431, alpha: 1)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }
    
}
