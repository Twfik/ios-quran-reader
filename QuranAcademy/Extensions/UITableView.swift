//
//  UITableView+extension.swift
//  QuranAcademy
//
//  Created by Abdul Tawfik on 28/08/2018.
//  Copyright © 2018 Abdullah Tawfik. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UITableViewCell>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: T.self))
        
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T // swiftlint:disable:this force_cast
    }
    
    // MARK: - Header & Footer
    public func registerNibHeader<T: UIView>(_: T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    public func dequeueHeaderFooter<T: UIView>(_: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}
