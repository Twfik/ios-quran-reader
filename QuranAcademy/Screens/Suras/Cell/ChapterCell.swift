//
//  Sura.swift
//  QuranAcademy
//
//  Created by Ayub on 13/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class ChapterCell: UICollectionViewCell {
    
    @IBOutlet weak var suraArLabel: UILabel!
    @IBOutlet weak var suraTranslationLabel: UILabel!
    @IBOutlet weak var suraNumberLabel: UILabel!
    @IBOutlet weak var suraTransliterationLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var suraNumberContainerView: NeverClearView!
    @IBOutlet weak var ayahCountLabel: UILabel!
    
    func configure(sura: Sura) {
//        suraArLabel.text = "\(sura.id)"
        suraTranslationLabel.text = "\(sura.translation)"
        suraTransliterationLabel.text = "\(sura.transliteration)"
        suraNumberLabel.text = "\(sura.id)"
        ayahCountLabel.text = "\(sura.ayatCount) аятов"
    }
    
    override func awakeFromNib() {
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9215686275, blue: 0.8431372549, alpha: 0.502640625)
        selectedBackgroundView = selectedView
        
//        suraArLabel.highlightedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        suraTranslationLabel.highlightedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        suraTransliterationLabel.highlightedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        ayahCountLabel.highlightedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        suraNumberLabel.highlightedTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        self.layer.cornerRadius = 6
        self.layer.borderColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
        self.layer.borderWidth = 1
        self.clipsToBounds = true
    }
    
}

// Это нужно, чтобы нажатие на ячейку не перекрывало вьюшку
class NeverClearView: UIView {
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }
}
