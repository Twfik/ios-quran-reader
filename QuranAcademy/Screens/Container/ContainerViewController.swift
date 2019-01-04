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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSplashView()
        
        viewModel.getLanguages().subscribe(onSuccess: { [weak self] (response) in
            self?.showLanguagesView(response.languages)
//            self?.splashVC?.removeFromSuperview()
//            self?.splashVC = nil
        }, onError: { (error) in
            print(error)
        }).disposed(by: bag)
        
        
    }
    
    private func setSplashView() {
        splashVC = UIView.viewFromNibName("SplashView")
        splashVC?.frame = self.view.frame
        self.view.addSubview(splashVC ?? UIView())
    }
    
    private func showLanguagesView(_ languages: [LanguagesJSON]) {
        let languagesView = UIStoryboard.get(LanguagesViewController.self)
        let viewModel = LanguagesViewModel(languages: languages)
        languagesView.viewModel = viewModel
        languagesView.modalPresentationStyle = .overCurrentContext
        languagesView.modalTransitionStyle = .crossDissolve
        present(languagesView, animated: true)
    }
    
}
