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
        .font: TranslationFont.current.font,
        .paragraphStyle: translationParagraphStyle
    ]
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var translationLabel: UILabel!
    
    func configure(_ translation: Tafsir) {
        translationLabel.attributedText = NSAttributedString(string: translation.text, attributes: TranslationCell.translationTextAttributes)
    }
    
    override func awakeFromNib() {
        translationLabel.font = TranslationFont.current.font
        translationLabel.textColor = Theme.current.translationTextColor
        containerView.backgroundColor = Theme.current.translationCellBackgroundColor
        containerView.layer.cornerRadius = 5
        containerView.clipsToBounds = true
        backgroundColor = Theme.current.arabicCellBackgroundColor
    }

}
