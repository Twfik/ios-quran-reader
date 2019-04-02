//
//  FontCell.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class FontCell: UITableViewCell {

    @IBOutlet weak var fontLabel: UILabel!
    
    func configure(font: String, currentFont: String) {
        fontLabel.text = font
        setupCheckmark(font: font, currentFont: currentFont)
    }
    
    func setupCheckmark(font: String, currentFont: String) {
        if font == currentFont {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
}
