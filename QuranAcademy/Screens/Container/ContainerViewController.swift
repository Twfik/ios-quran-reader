//
//  ContainerViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 13/04/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit
import RxSwift

final class ContainerViewController: UIViewController {
    
    let viewModel = ContainerViewModel()
    
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
        languages.isEmpty ? fetchIntroItems() : setWelcomeVC()
    }
    
    private func setWelcomeVC() {
        let welcomeVC = UIStoryboard.get(WelcomeViewController.self)
        let navi = UINavigationController(rootViewController: welcomeVC)
        set(navi, animated: true)
    }
    
    private func setTabbar() {
        let tabbar = UIStoryboard.get(MainTabBarController.self)
        let navigationVC = UINavigationController(rootViewController: tabbar)
        UserDefaults.standard.set(true, forKey: Keys.isСonfigured)
        set(navigationVC, animated: true)
    }
    
}
