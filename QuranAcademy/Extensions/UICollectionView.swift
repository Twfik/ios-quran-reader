//
//  UICollectionView.swift
//  QuranAcademy
//
//  Created by Ayub on 09.08.2018.
//  Copyright © 2018 Ayub. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UICollectionViewCell>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T // swiftlint:disable:this force_cast
    }
    
}

extension UICollectionView {
    
    func setEmptyData(_ text: String) {
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        textLabel.text = text
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Avenir-Light", size: 15)
        textLabel.sizeToFit()
        self.backgroundView = textLabel
    }
    
    func clearBackgroundView() {
        self.backgroundView = nil
    }
    
}

extension UICollectionView {
    
    func scrollToBottom(animated: Bool) {
        guard numberOfSections > 0 else {
            return
        }
        
        let lastSection = numberOfSections - 1
        
        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: animated)
    }
}
