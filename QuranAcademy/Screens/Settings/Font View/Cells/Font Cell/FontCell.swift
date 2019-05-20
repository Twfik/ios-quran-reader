//
//  FontCell.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class FontCell: UITableViewCell {

    var cellModel: FontCellModel!
    
    @IBOutlet weak var fontLabel: UILabel!
    
    func configure(withModel model: FontCellModel) {
        self.cellModel = model
        
        fontLabel.text = cellModel.fontName
        setupCheckmark(font: cellModel.fontName, currentFont: cellModel.currentFont)
        
        fontLabel.textColor = Theme.current.textColor
        backgroundColor = Theme.current.backgroundColor
    }
    
    func setupCheckmark(font: String, currentFont: String) {
        if font == currentFont {
            accessoryType = .checkmark
        } else {
            accessoryType = .none
        }
    }
    
}
