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
    
    func registerFooterNib<T: UITableViewHeaderFooterView>(_:T.Type) {
        let nib = UINib(nibName: String(describing: T.self), bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
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
    
    func setTableHeaderView(header: UIView, height: CGFloat? = nil) {
        self.tableHeaderView = header
        header.setNeedsLayout()
        header.layoutIfNeeded()
        let viewHeight = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var frame = header.frame
        frame.size.height = height == nil ? viewHeight : height ?? 0
        header.frame = frame
        self.tableHeaderView = header
    }
    
    func setHeaderView(text: String) {
        let headerView = UIView()
        let headerLabel = UILabel()
        let headerText = text
        let textSize: CGFloat = 24
        let padding: CGFloat = 20
        // Расчет высоты заголовка в зависимости от длины текста с padding
        let maxSize = CGSize(width: self.bounds.width - padding * 2, height: CGFloat.infinity)
        let textBoundingRect = (headerText as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: textSize)], context: nil).height.rounded(.up)
        let headerViewHeight = textBoundingRect + padding * 2
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: headerViewHeight)
        headerLabel.frame = CGRect(x: 0, y: 0, width: headerView.bounds.width, height: headerView.bounds.height)
        headerLabel.textAlignment = .center
        headerLabel.numberOfLines = 0
        headerLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        headerLabel.font = UIFont.systemFont(ofSize: textSize)
        headerLabel.text = headerText
        
        headerView.addSubview(headerLabel)
        self.tableHeaderView = headerView
        
        self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
    }
    
    func setEmptyData(_ text: String, textColor: UIColor = .black, textSize: CGFloat = 15) {
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        textLabel.text = text
        textLabel.textColor = textColor
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: "Avenir-Light", size: textSize)
        textLabel.sizeToFit()
        self.backgroundView = textLabel
    }
    
    func clearBackgroundView() {
        self.backgroundView = nil
    }
    
}
