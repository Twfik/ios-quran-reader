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
        tabBarController?.tabBar.isTranslucent = false
        setupNavigationBar()
    }
    
    private func setupFirstViewController() {
           guard let surasViewController = children.first as? ChaptersViewController else { return }
        let viewModel = ChaptersViewModel()
        surasViewController.viewModel = viewModel
    }
    
    private func setupTabBar() {
        title = "Коран"
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.barTintColor = Theme.current.navigationBarColor
        navigationController?.navigationBar.shadowImage = nil
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }
    
}
