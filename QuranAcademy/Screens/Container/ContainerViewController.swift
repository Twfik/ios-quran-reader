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
            return .default
        }
        return viewControllerToCheck.preferredStatusBarStyle
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setSplashView()
        fetchLanguages()
    }
    
    private func fetchLanguages() {
        viewModel.getLanguages().subscribe(onSuccess: { [weak self] (response) in
            self?.setIntroVC(response.languages)
            self?.removeSplashView()
            }, onError: { (error) in
                print(error)
        }).disposed(by: bag)
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
    
    private func setIntroVC(_ languages: [LanguagesJSON]) {
        let introVC = UIStoryboard.get(IntroViewController.self)
        let navi = UINavigationController(rootViewController: introVC)
        let viewModel = IntroViewModel(languages: languages, provider: self.viewModel.provider)
        introVC.viewModel = viewModel
        set(navi, animated: true)
        setNeedsStatusBarAppearanceUpdate()
    }
    
}
