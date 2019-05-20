//
//  FontSizeCell.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class FontSizeCell: UITableViewCell {
    
    var cellModel: FontSizeCellModel!
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBAction func fontSizeSliderValueChanged(_ sender: UISlider) {
        cellModel.sliderValueChanged?(sender.value)
    }
    
    func configure(withModel model: FontSizeCellModel) {
        self.cellModel = model
        
        minLabel.textColor = Theme.current.textColor
        maxLabel.textColor = Theme.current.textColor
        backgroundColor = Theme.current.backgroundColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
