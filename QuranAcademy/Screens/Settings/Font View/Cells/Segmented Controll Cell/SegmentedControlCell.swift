//
//  SegmentedControlCell.swift
//  QuranAcademy
//
//  Created by Ayub on 03/05/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class SegmentedControlCell: UITableViewCell {
    
    var cellModel: SegmentedControlCellModel!
    
    @IBOutlet weak var fontSegmentedControl: UISegmentedControl!
    
    @IBAction func fontSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        cellModel.segmentedControlValueChanged?(sender.selectedSegmentIndex)
    }
    
    func configure(withModel model: SegmentedControlCellModel) {
        self.cellModel = model
        
        fontSegmentedControl.tintColor = Theme.current.mainColor
        fontSegmentedControl.backgroundColor = .clear
        backgroundColor = Theme.current.backgroundColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
