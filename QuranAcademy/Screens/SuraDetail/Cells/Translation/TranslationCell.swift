//
//  TranslationCell.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class TranslationCell: UITableViewCell {

    static var translationParagraphStyle: NSParagraphStyle = {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping
        style.hyphenationFactor = 0
        return style
    }()
    
    static var translationTextAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: Preferences.translationFont, size: CGFloat(Preferences.translationFontSize))!,
        .paragraphStyle: translationParagraphStyle
    ]
    
    @IBOutlet weak var translationLabel: UILabel!
    
    func configure(_ translation: Tafsir) {
        translationLabel.attributedText = NSAttributedString(string: translation.text, attributes: TranslationCell.translationTextAttributes)
    }
    
    override func awakeFromNib() {
        translationLabel.font = UIFont(name: Preferences.translationFont, size: CGFloat(Preferences.translationFontSize))
    }

}
