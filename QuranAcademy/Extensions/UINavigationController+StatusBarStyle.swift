//
//  UINavigationController+StatusBarStyle.swift
//  QuranAcademy
//
//  Created by Abdurahim Jauzee on 11/10/2018.
//  Copyright © 2018 Ayub. All rights reserved.
//

import UIKit

extension UINavigationController {

    private var viewController: UIViewController {
        return presentedViewController ?? topViewController ?? self
    }

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return viewController.preferredStatusBarStyle
    }

    override open var prefersStatusBarHidden: Bool {
        return viewController.prefersStatusBarHidden
    }

}
