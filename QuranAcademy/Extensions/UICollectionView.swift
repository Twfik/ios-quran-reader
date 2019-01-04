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
    
    func setEmptyData(_ message: String, image: String) {
        let view = UIView()
        view.frame = self.frame
        
        let backgroundLabel: UILabel = {
            let height = UIScreen.main.bounds.height
            let width = UIScreen.main.bounds.width
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 10, height: 50))
            label.center = CGPoint(x: width / 2, y: height / 2)
            label.text = message
            label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = UIFont(name: "Avenir-Light", size: 17)
            return label
        }()
        
        let image = UIImage(named: image)
        let backgroundImageView: UIImageView = {
            let imageView = UIImageView(frame: CGRect(x: (view.frame.width / 2) - 50, y: view.frame.height / 2 - 70, width: 100, height: 100))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundLabel)

        self.backgroundView = view
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
