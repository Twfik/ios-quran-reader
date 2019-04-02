//
//  BasmalaCell.swift
//  QuranAcademy
//
//  Created by Ayub on 04/03/2019.
//  Copyright © 2019 Ayub. All rights reserved.
//

import UIKit

class BasmalaHeader: UIView {

    @IBOutlet weak var label: UILabel!
    
    func configure(_ data: Basmala) {
        label.text = data.basmala
    }
    
}
