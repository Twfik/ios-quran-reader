//
//  WelcomeViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 22/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.8431372549, alpha: 1)
        
    }

    @IBAction func setupButtonTapped(_ sender: UIButton) {
        let introVC = UIStoryboard.get(LanguagesViewController.self)
        var viewModel = LanguagesViewModel()
        let containerVM = ContainerViewModel()
        viewModel.containerViewModel = containerVM
        introVC.viewModel = viewModel
        push(introVC, animated: true)
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        let tabbar = UIStoryboard.get(MainTabBarController.self)
        UserDefaults.standard.set(true, forKey: Keys.isСonfigured)
        navigationController?.setNavigationBarHidden(true, animated: true)
        push(tabbar, animated: true)
    }
    
}
