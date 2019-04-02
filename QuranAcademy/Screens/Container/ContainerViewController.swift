//
//  ContainerViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 04/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

final class ContainerViewController: UIViewController {
    
    let viewModel = ContainerViewModel()
    var splashVC: UIView?
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let viewControllerToCheck = presentedViewController ?? children.last else {
            return .lightContent
        }
        return viewControllerToCheck.preferredStatusBarStyle
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setSplashView()
        setNeedViewController()
    }
    
    private func setNeedViewController() {
        let isСonfigured = UserDefaults.standard.bool(forKey: Keys.isСonfigured)
        isСonfigured ? setTabbar() : beginSetuping()
    }
    
    private func fetchIntroItems() {
        viewModel.getIntroItems()
            .subscribe(onNext: { [weak self] (languages, translations, wordTranslations, suras) in
                self?.viewModel.save(languages,
                                      translations,
                                      wordTranslations,
                                      suras)
                
                self?.setWelcomeVC()
            }, onError: { (error) in
                print(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    private func beginSetuping() {
        let db = SQLiteStorage()
        let languages: [Language] = db.objects(Language.self)
        
        if languages.isEmpty {
            fetchIntroItems()
        } else {
            setWelcomeVC()
        }
    }
    
    private func setSplashView() {
        splashVC = UIView.viewFromNibName("SplashView")
        splashVC?.frame = self.view.frame
        self.view.addSubview(splashVC ?? UIView())
    }
    
    private func removeSplashView() {
        splashVC?.removeFromSuperview()
        splashVC = nil
    }
    
    private func setWelcomeVC() {
        let welcomeVC = UIStoryboard.get(WelcomeViewController.self)
        let navi = UINavigationController(rootViewController: welcomeVC)
        UIView.animate(withDuration: 0.5) {
            self.set(navi, animated: true)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.removeSplashView()
        })

    }
    
    private func setTabbar() {
        let tabbar = UIStoryboard.get(MainTabBarController.self)
        UserDefaults.standard.set(true, forKey: Keys.isСonfigured)
        set(tabbar, animated: true)
    }

    
}
