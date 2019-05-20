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
    
    func configure(sura: Sura, unicode: Int) {
        if let scalar = UnicodeScalar(unicode) {
            suraArLabel.text = "\(scalar)"
        }
        suraTranslationLabel.text = "\(sura.translation)"
        suraTransliterationLabel.text = "\(sura.transliteration)"
        suraNumberLabel.text = "\(sura.id)"
        let ayah = getWorkByDeclension(sura.ayatCount, ["аят", "аята", "аятов"]) ?? ""
        ayahCountLabel.text = "\(sura.ayatCount) \(ayah)"
        
        suraTranslationLabel.textColor = Theme.current.textColor
        suraTransliterationLabel.textColor = Theme.current.textColor
        suraNumberLabel.textColor = Theme.current.textColor
        ayahCountLabel.textColor = Theme.current.textColor
        suraArLabel.textColor = Theme.current.textColor
        containerView.backgroundColor = Theme.current.collectionCellBackgroundColor
        
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = Theme.current.collectionViewCellSelectingColor
        selectedBackgroundView = selectedView
        
        self.layer.cornerRadius = 6
        self.layer.borderColor = Theme.current.collectionCellBorderColor.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = true

    }
    
    func getWorkByDeclension(_ number: Int, _ arrayWords: [String]?) -> String? {
        var number = number
        var resultString = ""
        number = number % 100
        if number >= 11 && number <= 19 {
            resultString = arrayWords?[2] ?? ""
        } else {
            let i: Int = number % 10
            switch i {
            case 1:
                resultString = arrayWords?[0] ?? ""
            case 2, 3, 4:
                resultString = arrayWords?[1] ?? ""
            default:
                resultString = arrayWords?[2] ?? ""
            }
        }
        return resultString
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
