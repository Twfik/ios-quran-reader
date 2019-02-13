//
//  TranslationCell.swift
//  QuranAcademy
//
//  Created by Ayub on 07/02/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class TranslationCell: UITableViewCell {
    
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var translationLanguageLabel: UILabel!
    
    func configure(translation: Translation, language: String) {
        translationLabel.text = translation.name
        translationLanguageLabel.text = language
        
        if Preferences.translationCode == translation.code {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
    override func awakeFromNib() {
        self.tintColor = #colorLiteral(red: 0, green: 0.737254902, blue: 0.8431372549, alpha: 1)
    }
    
}
