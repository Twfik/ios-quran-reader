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
    }
    
    private func setupFirstViewController() {
        guard let navigationController = children.first as? UINavigationController,
            let surasViewController = navigationController.topViewController as? SurasViewController else { return }
        let viewModel = SurasViewModel()
        surasViewController.viewModel = viewModel
    }
    
    private func setupTabBar() {
        title = "Коран"
        tabBar.tintColor = #colorLiteral(red: 0.1882352941, green: 0.4, blue: 0.6039215686, alpha: 1)
    }
    
}
