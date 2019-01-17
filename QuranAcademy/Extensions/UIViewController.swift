//
//  UIViewController.swift
//  QuranAcademy
//
//  Created by Ayub on 05.05.2018.
//  Copyright © 2018 Ayub. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func disableAutomaticScrollViewInsets() {
        if #available(iOS 11, *) {} else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

    }

    func add(_ child: UIViewController, animated: Bool = false) {
        child.willMove(toParent: self)
        addChild(child)
        view.addSubview(child.view)
        child.view.alpha = animated ? 0 : 1
        child.view.frame = view.bounds
        child.didMove(toParent: self)
        setNeedsStatusBarAppearanceUpdate()
        guard animated else {
            return
        }
        UIView.animate(withDuration: 0.25) {
            child.view.alpha = 1
        }
    }

     func delayTappingOn(_ sender: UIButton) {
        sender.isEnabled = !sender.isEnabled
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            sender.isEnabled = !sender.isEnabled
        }
    }

    func remove(_ child: UIViewController, animated: Bool = false) {
        UIView.animate(withDuration: animated ? 0.25 : 0, animations: {
            child.view.alpha = 0
        }, completion: { _ in
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        })
    }
    
    func set(_ child: UIViewController, animated: Bool = false) {
        children.forEach {
            self.remove($0, animated: animated)
        }
        add(child, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
}

extension UIViewController {
    
    func showAlert(title: String?, message: String?, actionTitle: String = "Понятно", handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
            handler?()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    
    /// Добавляет жест для закрытия клавиатуры
    func setupKeyboardHidingGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// Скрыть клавиатуру
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// Animations
extension UIViewController {
    
    func animate(view: UIView, on: Bool, scale: CGFloat = 0.4, completion: (() -> Void)? = nil) {
        //        let damping: CGFloat = on ? 0.8 : 1
        //        let duration: Double = on ? 0.5 : 0.25
        //        let velocity: CGFloat = on ? 1 : 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: [], animations: {
            view.alpha = on ? 1 : 0
            view.transform = on ? .identity : CGAffineTransform(scaleX: scale, y: scale)
            if on == false {
                self.view.alpha = 0
            }
        }, completion: { _ in
            completion?()
        })
    }
    
}
