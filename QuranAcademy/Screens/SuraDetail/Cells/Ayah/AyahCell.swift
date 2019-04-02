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
    
    func configure(_ sura: Ayat) {
        let quranText = Preferences.arabicFont == "me_quran2" ? "\(sura.text_mequran)\n" : sura.text
        arabicLabel.text = quranText
        ayahNumberLabel.text = "\(sura.ayat_number)\n"
    }
    
    override func awakeFromNib() {
        arabicLabel.font = UIFont(name: Preferences.arabicFont, size: CGFloat(Preferences.arabicFontSize))
        ayahNumberLabel.font = UIFont(name: "me_quran2", size: 25)
    }

}
