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
    @IBOutlet weak var translationLabel: UILabel!
    @IBOutlet weak var ayahNumberLabel: UILabel!
    
    func configure(sura: Ayats) {
        arabicLabel.text = sura.text
        translationLabel.text = "Тут будет смысловой перевод"
        ayahNumberLabel.text = "\(sura.ayat)"
    }
    
}
