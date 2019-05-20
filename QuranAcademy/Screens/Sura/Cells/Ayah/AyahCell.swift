//
//  AyahCell.swift
//  QuranAcademy
//
//  Created by Ayub on 14/01/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

final class AyahCell: UITableViewCell {
    
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var ayahNumberLabel: UILabel!
    @IBOutlet weak var containerAyahNumberView: UIView!
    
    func configure(_ sura: Ayat) {
        let quranText = sura.text
        arabicLabel.text = quranText
        ayahNumberLabel.text = "\(sura.ayat)"
    }
    
    override func awakeFromNib() {
        arabicLabel.font = ArabicFont.current.font
        backgroundColor = Theme.current.arabicCellBackgroundColor
        arabicLabel.textColor = Theme.current.textColor
        ayahNumberLabel.textColor = Theme.current.textColor
        
        containerAyahNumberView.backgroundColor = Theme.current.translationCellBackgroundColor
        containerAyahNumberView.layer.cornerRadius = 5
        containerAyahNumberView.clipsToBounds = true
//        containerAyahNumberView.layer.borderColor = Theme.current.translationTextColor.cgColor
//        containerAyahNumberView.layer.borderWidth = 0.5
    }

}
