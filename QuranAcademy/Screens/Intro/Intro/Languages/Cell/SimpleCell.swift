//
//  LanguageCell.swift
//  QuranAcademy
//
//  Created by Ayub on 23/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class SimpleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ language: Language) {
        titleLabel.text = language.name
        setupCellCheckmark(language)
    }
    
    func setupCellCheckmark(_ language: Language) {
        if Preferences.code == language.code {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
    override func didMoveToSuperview() {
        self.tintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.8431372549, alpha: 0.704546875)
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.8431372549, alpha: 0.704546875)
        selectedBackgroundView = selectedView
    }
    
}
